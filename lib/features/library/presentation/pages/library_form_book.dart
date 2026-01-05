import 'package:flutter/material.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';

class LibraryFormBook extends StatelessWidget {
  const LibraryFormBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Book',
          style: AppTextStyle.heading3(
            fontWeight: AppTextStyle.medium,
            color: AppColor.neutral900,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
