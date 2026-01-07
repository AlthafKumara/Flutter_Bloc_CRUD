import '../../../../core/themes/app_color.dart';
import '../../domain/entities/book_entity.dart';
import '../cubit/library_form/library_form_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerCover extends StatelessWidget {
  LibraryFormState? state;
  BookEntity? book;
  ContainerCover({super.key, this.state, this.book});

  @override
  Widget build(BuildContext context) {
    final file = state?.newCoverFile;
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
      child: file != null
          ? null
          : book?.coverUrl != null
          ? null
          : Icon(Icons.add, size: 20.sp),
    );
  }
}
