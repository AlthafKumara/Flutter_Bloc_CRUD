import '../cubit/library/library_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book_entity.dart';
import '../../../../routes/app_routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';

class DefaultBookCard extends StatelessWidget {
  final BookEntity book;

  const DefaultBookCard({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await context.pushNamed(
          AppRoutes.libraryBookDetail.name,
          extra: book,
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
          shape: BoxShape.rectangle,
          border: Border.all(
            color: AppColor.neutral300,
            width: 1.w,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 88.w,
              height: 118.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: AppColor.neutral300,
                  style: BorderStyle.solid,
                  width: 1.w,
                ),
                image: DecorationImage(
                  image: NetworkImage(book.coverUrl ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              child: book.coverUrl == null || book.coverUrl == ""
                  ? Center(
                      child: Icon(
                        Icons.cloud_off_outlined,
                        size: 20.sp,
                        color: AppColor.neutral400,
                      ),
                    )
                  : Container(),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title!,
                    style: AppTextStyle.body2(
                      fontWeight: AppTextStyle.bold,
                      color: AppColor.neutral900,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    book.author!,
                    style: AppTextStyle.body2(
                      fontWeight: AppTextStyle.medium,
                      color: AppColor.neutral400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 6.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
