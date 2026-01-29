import '../../data/models/local/local_book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/utils/validator.dart';
import '../../../../widgets/button_large.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/textfield.dart';
import '../cubit/library/library_cubit.dart';
import '../cubit/library_form/library_form_cubit.dart';
import '../cubit/library_form/library_form_state.dart';
import '../widgets/container_cover.dart';

class LibraryFormBook extends StatelessWidget {
  LibraryFormBook({super.key});

  final bookFormKey = GlobalKey<FormState>();
  final validator = Validator();

  void submitAdd(BuildContext context) {
    final formState = context.read<LibraryFormCubit>().state;

    if (!bookFormKey.currentState!.validate()) return;

    if (formState.newCoverFile == null) {
      CustomSnackbar.show(
        context,
        message: 'Cover harus diisi',
        backgroundColor: AppColor.danger600,
      );
      return;
    }

    context.read<LibraryCubit>().createBookWithCover(
      title: formState.title,
      author: formState.author,
      description: formState.description,
      coverPath: formState.newCoverFile!.path,
      coverFile: formState.newCoverFile!,
    );
  }

  void submitUpdate(
    BuildContext context, {
    required int localId,
    required String oldCoverUrl,
  }) {
    final formState = context.read<LibraryFormCubit>().state;

    if (!bookFormKey.currentState!.validate()) return;

    context.read<LibraryCubit>().updateBookWithOptionalCover(
      localId: localId,
      title: formState.title,
      author: formState.author,
      oldCoverUrl: oldCoverUrl,
      description: formState.description,

      newCoverFile: formState.newCoverFile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryCubit, LibraryState>(
      listener: (context, state) {
        if (state is UploadBookCoverErrorState ||
            state is CreateBookErrorState) {
          final message = state is UploadBookCoverErrorState
              ? state.message
              : (state as CreateBookErrorState).message;

          CustomSnackbar.show(
            context,
            message: message,
            backgroundColor: AppColor.danger600,
          );
        }

        if (state is CreateBookSuccessState) {
          CustomSnackbar.show(
            context,
            message: "Berhasil menambahkan buku",
            backgroundColor: AppColor.success500,
          );
          context.pop(true);
        }
        if (state is UpdateBookSuccessState) {
          CustomSnackbar.show(
            context,
            message: "Berhasil Update Buku ",
            backgroundColor: AppColor.success500,
          );
          context.pop(true);
          context.pop(true);
        }
      },
      child: BlocBuilder<LibraryFormCubit, LibraryFormState>(
        builder: (context, state) {
          final bookdata = GoRouterState.of(context).extra as LocalBookModel?;

          return Scaffold(
            backgroundColor: AppColor.neutral100,
            appBar: AppBar(
              title: const Text("Form Book"),
              scrolledUnderElevation: 0,
            ),
            body: Form(
              key: bookFormKey,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => context.read<LibraryFormCubit>().pickCover(),
                    child: Container(
                      height: 300,
                      color: AppColor.neutral250,
                      alignment: Alignment.center,
                      child: ContainerCover(state: state, book: bookdata),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        CustomTextfield.textFieldLarge(
                          initialValue: bookdata?.title,
                          label: 'Title',
                          validator: validator.validatorTitle,
                          onChanged: context
                              .read<LibraryFormCubit>()
                              .titleChanged,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextfield.textFieldLarge(
                          initialValue: bookdata?.description,
                          label: 'Synopsis',
                          maxLines: 5,
                          validator: validator.validatorSynopsis,
                          onChanged: context
                              .read<LibraryFormCubit>()
                              .descriptionChanged,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextfield.textFieldLarge(
                          initialValue: bookdata?.author,
                          label: 'Author',
                          validator: validator.validatorAuthor,
                          onChanged: context
                              .read<LibraryFormCubit>()
                              .authorChanged,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(16.w),
              child: CustomButtonLarge.primarylarge(
                text: bookdata != null ? 'Update' : 'Submit',
                onPressed: () {
                  if (bookdata != null) {
                    submitUpdate(
                      context,
                      localId: bookdata.localId!,
                      oldCoverUrl: bookdata.coverUrl!,
                    );
                  } else {
                    submitAdd(context);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
