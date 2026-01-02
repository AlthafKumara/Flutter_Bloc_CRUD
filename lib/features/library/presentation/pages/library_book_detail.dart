import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';
import '../../data/models/get_books_model.dart';

class LibraryBookDetail extends StatelessWidget {
  final GetBooksModel book;
  const LibraryBookDetail({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.neutral100,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text(
          'Book Detail',
          style: AppTextStyle.heading3(
            fontWeight: AppTextStyle.bold,
            color: AppColor.neutral900,
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
        actions: [
          GestureDetector(
            onTap: () {}, // ROUTE KE FORM BOOK EDIT
            child: Container(
              margin: EdgeInsets.only(right: 16.w),
              child: Icon(Icons.edit, color: AppColor.primary500),
            ),
          ),

          GestureDetector(
            child: Icon(Icons.delete, color: AppColor.danger500),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
