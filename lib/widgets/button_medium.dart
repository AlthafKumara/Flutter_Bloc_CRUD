import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/themes/app_color.dart';
import '../core/themes/app_text_style.dart';

class CustomButtonMedium {
  CustomButtonMedium._();

  static Widget primaryMedium({
    final Color color = AppColor.primary500,
    final void Function()? onPressed,
    final String text = "Button",
    final Widget? prefixicon,
    final Widget? suffixicon,
    final bool? isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 12.w),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColor.primary600;
          }
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutral250;
          }
          return color;
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
            SizedBox(width: 20.w, height: 20.w, child: prefixicon),

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
            Text(
              text,
              style: AppTextStyle.body2(
                color: AppColor.neutral100,
                fontWeight: AppTextStyle.semiBold,
              ),
            ),
          if (suffixicon != null)
            SizedBox(width: 20.w, height: 20.w, child: suffixicon),
        ],
      ),
    );
  }
}
