import 'dart:io';

import 'package:crud_clean_bloc/features/library/data/models/get_books_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_color.dart';
import '../cubit/library_form/library_form_state.dart';

class ContainerCover extends StatelessWidget {
  LibraryFormState? state;
  GetBooksModel? book;
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
            : book?.coverPath != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(book!.coverPath!)),
              )
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
