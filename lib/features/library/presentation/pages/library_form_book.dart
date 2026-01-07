import 'package:crud_clean_bloc/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/utils/validator.dart';
import '../../../../widgets/button_large.dart';
import '../../../../widgets/textfield.dart';
import '../../domain/entities/book_entity.dart';
import '../cubit/library/library_cubit.dart';
import '../cubit/library_form/library_form_cubit.dart';
import '../cubit/library_form/library_form_state.dart';

class LibraryFormBook extends StatelessWidget {
  LibraryFormBook({super.key});

  final bookFormKey = GlobalKey<FormState>();
  final validator = Validator();

  void submit(BuildContext context) {
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
      coverFile: formState.newCoverFile!,
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
          context.read<LibraryCubit>().getAllBooks();
          CustomSnackbar.show(
            context,
            message: "Berhasil menambahkan buku",
            backgroundColor: AppColor.success500,
          );
          context.pop();
        }
      },
      child: BlocBuilder<LibraryFormCubit, LibraryFormState>(
        builder: (context, state) {
          final bookdata = GoRouterState.of(context).extra as BookEntity?;

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
                      child: _buildCover(state, bookdata),
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
                text: 'Submit',
                onPressed: () => submit(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCover(LibraryFormState state, final BookEntity? book) {
    final file = state.newCoverFile;

    return Container(
      width: 180.w,
      height: 280.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColor.neutral400.withValues(alpha: 0.5),
        image: file != null
            ? DecorationImage(fit: BoxFit.cover, image: FileImage(file))
            : book?.coverUrl != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(book!.coverUrl!),
              )
            : null,
      ),
      child: file != null ? null : Icon(Icons.add, size: 20.sp),
    );
  }
}
