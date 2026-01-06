import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/themes/app_color.dart';
import '../core/themes/app_text_style.dart';

class CustomButtonLarge {
  CustomButtonLarge._();

  static Widget primarylarge({
    final void Function()? onPressed,
    final String? text,
    final Widget? prefixicon,
    final Widget? suffixicon,
    final bool? isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColor.primary600;
          }
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutral250;
          }
          return AppColor.primary500;
        }),
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutral400;
          }
          return AppColor.neutral100;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixicon != null)
            SizedBox(width: 24.w, height: 24.w, child: prefixicon),

          if (isLoading == true)
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColor.neutral100,
              ),
            ),
          if (isLoading == false)
            if (text != null)
              Text(
                text,
                style: AppTextStyle.body2(
                  color: AppColor.neutral100,
                  fontWeight: AppTextStyle.semiBold,
                ),
              ),
          if (suffixicon != null)
            SizedBox(width: 24.w, height: 24.w, child: suffixicon),
        ],
      ),
    );
  }

  static Widget outlinelarge({
    final void Function()? onPressed,
    final String? text,
    final Widget? prefixicon,
    final Widget? suffixicon,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor.neutral300),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutral250;
          }
          return AppColor.neutral200;
        }),
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutral400;
          }
          return AppColor.neutral900;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixicon != null)
            SizedBox(width: 24.w, height: 24.w, child: prefixicon),
          if (prefixicon != null && text != null) SizedBox(width: 8.w),
          if (text != null)
            Text(
              text,
              style: AppTextStyle.body2(fontWeight: AppTextStyle.semiBold),
            ),
          if (text != null && suffixicon != null) SizedBox(width: 8.w),
          if (suffixicon != null)
            SizedBox(width: 24.w, height: 24.w, child: suffixicon),
        ],
      ),
    );
  }
}
