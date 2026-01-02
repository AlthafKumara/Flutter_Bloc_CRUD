// import 'package:crud_clean_bloc/features/library/data/models/get_books_model.dart';
// import 'package:crud_clean_bloc/features/library/presentation/widgets/default_book_card.dart';
import 'package:crud_clean_bloc/widgets/button_medium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Library',
          style: AppTextStyle.heading3(
            fontWeight: AppTextStyle.bold,
            color: AppColor.neutral900,
          ),
        ),
        actions: [
          CustomButtonMedium.primaryMedium(
            color: AppColor.primary500,
            text: 'Add Book',
            isLoading: false,
            onPressed: () {},
            prefixicon: SizedBox(
              height: 20.w,
              width: 20.w,
              child: Icon(Icons.add, color: AppColor.neutral100),
            ),
          ),
        ],
      ),
      // body: _buildList(),
    );
  }

  // Widget _buildList(List<GetBooksModel> books) {
  //   return ListView.builder(
  //     scrollDirection: Axis.vertical,
  //     itemBuilder: (context, index) {
  //       return DefaultBookCard(book: books[index]);
  //     },
  //     itemCount: books.length,
  //   );
  // }
}
