import 'package:crud_clean_bloc/core/themes/app_color.dart';
import 'package:crud_clean_bloc/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function() onTap;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.primary500,

      title: Text(
        title,
        style: AppTextStyle.body1(
          color: AppColor.neutral100,
          fontWeight: AppTextStyle.bold,
        ),
      ),
      content: Text(
        message,
        style: AppTextStyle.description2(
          color: AppColor.neutral100,
          fontWeight: AppTextStyle.regular,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: AppTextStyle.body2(color: AppColor.neutral100),
          ),
        ),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.neutral100),
          child: Text(
            'OK',
            style: AppTextStyle.body2(color: AppColor.primary500),
          ),
        ),
      ],
    );
  }
}
