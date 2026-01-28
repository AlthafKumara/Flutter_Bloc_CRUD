import 'dart:io';

import 'package:crud_clean_bloc/features/library/data/models/get_books_model.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';
import '../cubit/library/library_cubit.dart';
import '../../../../routes/app_routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookCardItem extends StatelessWidget {
  final GetBooksModel? book;
  final bool isConnected;
  final bool isLoading;
  bool? isSync;

  BookCardItem({
    super.key,
    this.book,
    this.isLoading = false,
    this.isSync,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _loadingCard();
    }
    return _bookCard(context);
  }

  Widget _loadingCard() {
    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.neutral100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.neutral300),
        ),
        child: Row(
          children: [
            Container(
              width: 88.w,
              height: 118.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.neutral300),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loading Title',
                    style: AppTextStyle.body2(fontWeight: AppTextStyle.bold),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Loading Author',
                    style: AppTextStyle.body2(fontWeight: AppTextStyle.medium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookCard(BuildContext context) {
    final bookData = book!;

    return GestureDetector(
      onTap: () async {
        final result = await context.pushNamed(
          AppRoutes.libraryBookDetail.name,
          extra: bookData,
        );

        if (result == true) {
          context.read<LibraryCubit>().getAllBooks();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.neutral100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.neutral300),
        ),
        child: Row(
          children: [
            _bookCover(bookData.coverUrl),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isSync != null && isSync! == false
                      ? Text(
                          "Not Sync",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.description4(
                            fontWeight: AppTextStyle.regular,
                            color: AppColor.danger600,
                          ),
                        )
                      : SizedBox(),
                  Text(
                    bookData.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.body2(
                      fontWeight: AppTextStyle.bold,
                      color: AppColor.neutral900,
                    ),
                  ),
                  SizedBox(width: 8.w),

                  SizedBox(height: 6.h),
                  Text(
                    bookData.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.body2(
                      fontWeight: AppTextStyle.medium,
                      color: AppColor.neutral400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookCover(String? url) {
    return Container(
      width: 88.w,
      height: 118.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.neutral300),
        image: (url != null && isConnected && book!.coverPath == null)
            ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
            : book!.coverPath != null
            ? DecorationImage(
                image: FileImage(File(book!.coverPath!)),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: (url == null || !isConnected)
          ? Icon(Icons.cloud_off_outlined, color: AppColor.neutral400)
          : null,
    );
  }
}
