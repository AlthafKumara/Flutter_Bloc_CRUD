import 'package:crud_clean_bloc/features/library/domain/entities/book_entity.dart';
import 'package:crud_clean_bloc/routes/app_routes_path.dart';
import 'package:crud_clean_bloc/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';

class LibraryBookDetail extends StatelessWidget {
  const LibraryBookDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final bookdata = GoRouterState.of(context).extra as BookEntity;

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
            onTap: () {
              context.pushNamed(
                AppRoutes.libraryFormBook.name,
                extra: bookdata,
              );
            }, // ROUTE KE FORM BOOK EDIT
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
                  onTap: () {},
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
              child: Center(
                child: Container(
                  width: 180.w,
                  height: 280.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColor.neutral400.withValues(alpha: 0.5),
                    image: DecorationImage(
                      image: NetworkImage(bookdata.coverUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
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
              padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 16.w),
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
  }
}
