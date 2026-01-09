import '../../../../core/constants/assets_constant.dart';
import '../../../../widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';
import '../../../../routes/app_routes_path.dart';
import '../../../../widgets/button_medium.dart';
import '../../domain/entities/book_entity.dart';
import '../cubit/library/library_cubit.dart';
import '../widgets/default_book_card.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryPage> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryCubit>().getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral100,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.neutral100,
        title: Text(
          'Library',
          style: AppTextStyle.heading3(
            fontWeight: AppTextStyle.bold,
            color: AppColor.neutral900,
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 16.w),
        actions: [
          CustomButtonMedium.primaryMedium(
            color: AppColor.primary500,
            text: 'Add Book',
            isLoading: false,
            onPressed: () async {
              final result = await context.pushNamed(
                AppRoutes.libraryFormBook.name,
              );

              if (result == true) {
                context.read<LibraryCubit>().getAllBooks();
              }
            },
            prefixicon: SizedBox(
              height: 20.w,
              width: 20.w,
              child: Icon(Icons.add, color: AppColor.neutral100),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: BlocBuilder<LibraryCubit, LibraryState>(
          builder: (context, state) {
            if (state is GetAllBookLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primary500),
              );
            } else if (state is GetAllBookSuccessState) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextfield.textFieldRounded(
                          onChanged: (value) =>
                              context.read<LibraryCubit>().searchBooks(value),
                          enabled: true,
                          isObsecureText: false,
                          keyBoardType: TextInputType.text,
                          hintText: "Search Your Book Here",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          validator: null,
                          prefixicon: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: Image.asset(Assets.iconSearch),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  state.books.isEmpty
                      ? Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: const Center(child: Text('Tidak ada data')),
                          ),
                        )
                      : Expanded(child: _buildList(state.books)),
                ],
              );
            } else if (state is GetAllBookErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Tidak ada data'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary500,
        onPressed: () => context.read<LibraryCubit>().getAllBooks(),
        child: const Icon(Icons.refresh, color: AppColor.neutral100),
      ),
    );
  }

  Widget _buildList(List<BookEntity> books) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return DefaultBookCard(book: books[index]);
      },
      itemCount: books.length,
    );
  }
}
