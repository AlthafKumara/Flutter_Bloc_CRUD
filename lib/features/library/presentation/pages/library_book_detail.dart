import '../../domain/entities/book_entity.dart';
import '../cubit/library/library_cubit.dart';
import '../widgets/container_cover.dart';
import '../../../../routes/app_routes_path.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';

class LibraryBookDetail extends StatelessWidget {
  final BookEntity book;
  const LibraryBookDetail({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final bookdata = GoRouterState.of(context).extra as BookEntity;

    return BlocConsumer<LibraryCubit, LibraryState>(
      listener: (context, state) {
        if (state is DeleteBookErrorState) {
          CustomSnackbar.show(
            context,
            message: state.message,
            backgroundColor: AppColor.danger600,
          );
        }

        if (state is DeleteBookSuccessState) {
          context.read<LibraryCubit>().getAllBooks();
          CustomSnackbar.show(
            context,
            message: state.message,
            backgroundColor: AppColor.success500,
          );

          context.pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.neutral100,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColor.neutral100,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
            ),

            actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
            actions: [
              GestureDetector(
                onTap: () async {
                  final result = await context.pushNamed(
                    AppRoutes.libraryFormBook.name,
                    extra: bookdata,
                  );

                  if (result == true) {
                    context.read<LibraryCubit>().getAllBooks();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16.w),
                  child: Icon(Icons.edit, color: AppColor.primary500),
                ),
              ),

              GestureDetector(
                child: Icon(Icons.delete, color: AppColor.danger500),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => CustomDialog(
                      title: "Hapus Buku",
                      message: "Apakah anda yakin ingin menghapus buku ini ?",
                      onTap: () {
                        context.pop();
                        context.read<LibraryCubit>().deleteBook(
                          coverUrl: bookdata.coverUrl!,
                          id: bookdata.id!,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 12.h),
            child: ListView(
              children: [
                Container(
                  width: 395.w,
                  height: 320.h,
                  color: AppColor.neutral250,
                  child: Center(child: ContainerCover(book: bookdata)),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 16.w,
                    vertical: 22.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookdata.title!,
                        style: AppTextStyle.heading4(
                          fontWeight: AppTextStyle.medium,
                          color: AppColor.neutral900,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: AppColor.neutral250, thickness: 8.h),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 22.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                "Writer",
                                style: AppTextStyle.description2(
                                  fontWeight: AppTextStyle.medium,
                                  color: AppColor.neutral400,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${bookdata.author}",
                              style: AppTextStyle.description2(
                                fontWeight: AppTextStyle.medium,
                                color: AppColor.neutral900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: AppColor.neutral250, thickness: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 22.h,
                    horizontal: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Synopsis",
                        style: AppTextStyle.body1(
                          fontWeight: AppTextStyle.medium,
                          color: AppColor.neutral900,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        bookdata.description!,
                        style: AppTextStyle.description2(
                          fontWeight: AppTextStyle.regular,
                          color: AppColor.neutral500,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(color: AppColor.neutral250, thickness: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
