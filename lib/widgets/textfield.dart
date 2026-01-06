import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/themes/app_color.dart';
import '../core/themes/app_text_style.dart';

class CustomTextfield {
  CustomTextfield._();

  static Widget textFieldLarge({
    final String? label,
    final String? hintText,
    final Widget? prefixicon,
    final Widget? suffixicon,
    final TextEditingController? controller,
    final bool? isObsecureText,
    final String? initialValue,
    final int? maxLines,
    final TextInputType? keyBoardType,
    final bool? enabled,
    final TextAlign? textAlign = TextAlign.start,
    final void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: AppTextStyle.body2(
              color: AppColor.neutral900,
              fontWeight: AppTextStyle.medium,
            ),
          ),
        SizedBox(height: 6.h),
        TextFormField(
          initialValue: initialValue,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: onChanged,
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyBoardType,
          enabled: enabled,
          obscureText: isObsecureText ?? false,
          style: AppTextStyle.body2(
            color: AppColor.neutral900,
            fontWeight: AppTextStyle.regular,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.neutral100,

            hintText: hintText,
            hintStyle: AppTextStyle.body2(
              color: AppColor.neutral400,
              fontWeight: AppTextStyle.regular,
            ),

            errorStyle: AppTextStyle.body2(
              color: AppColor.danger600,
              fontWeight: AppTextStyle.regular,
            ),

            prefixIcon: prefixicon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: prefixicon,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: 20.w,
              minHeight: 20.w,
            ),
            suffixIcon: suffixicon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 8, right: 12),
                    child: suffixicon,
                  )
                : null,
            suffixIconConstraints: BoxConstraints(
              minWidth: 20.w,
              minHeight: 20.w,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.primary400),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.neutral300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.neutral300),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.danger500),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.danger500),
            ),
          ),
          validator: (value) {
            if (validator != null) {
              return validator(value);
            }
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  static Widget textFieldRounded({
    final String? label,
    final String? hintText,
    final Widget? prefixicon,
    final Widget? suffixicon,
    final TextEditingController? controller,
    final bool? isObsecureText,
    final int? maxLines,
    final TextInputType? keyBoardType,
    final bool? enabled,
    final TextAlign? textAlign = TextAlign.start,
    String? Function(String?)? validator,
  }) {
    if (label != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.body2(
              color: AppColor.neutral900,
              fontWeight: AppTextStyle.medium,
            ),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            textAlign: textAlign!,

            maxLines: maxLines,
            controller: controller,
            keyboardType: keyBoardType,
            enabled: enabled,
            obscureText: isObsecureText!,
            style: AppTextStyle.body2(
              color: AppColor.neutral900,
              fontWeight: AppTextStyle.regular,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.neutral100,

              hintText: hintText,
              hintStyle: AppTextStyle.body2(
                color: AppColor.neutral400,
                fontWeight: AppTextStyle.regular,
              ),

              errorStyle: AppTextStyle.body2(
                color: AppColor.danger600,
                fontWeight: AppTextStyle.regular,
              ),

              prefixIcon: prefixicon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 12, right: 8),
                      child: prefixicon,
                    )
                  : null,
              prefixIconConstraints: BoxConstraints(
                minWidth: 18.w,
                minHeight: 18.w,
              ),
              suffixIcon: suffixicon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 8, right: 12),
                      child: suffixicon,
                    )
                  : null,
              suffixIconConstraints: BoxConstraints(
                minWidth: 18.w,
                minHeight: 18.w,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(999.r),
                borderSide: BorderSide(color: AppColor.primary400),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(999.r),
                borderSide: BorderSide(color: AppColor.neutral300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(999.r),
                borderSide: BorderSide(color: AppColor.neutral300),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(999.r),
                borderSide: BorderSide(color: AppColor.danger500),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(999.r),
                borderSide: BorderSide(color: AppColor.danger500),
              ),
            ),
            validator: (value) {
              if (validator != null) {
                return validator(value);
              }
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      );
    }

    return TextFormField(
      textAlign: textAlign!,

      maxLines: maxLines,
      controller: controller,
      keyboardType: keyBoardType,
      enabled: enabled,
      obscureText: isObsecureText!,
      style: AppTextStyle.body2(
        color: AppColor.neutral900,
        fontWeight: AppTextStyle.regular,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.neutral100,

        hintText: hintText,
        hintStyle: AppTextStyle.body2(
          color: AppColor.neutral400,
          fontWeight: AppTextStyle.regular,
        ),

        errorStyle: AppTextStyle.body2(
          color: AppColor.danger600,
          fontWeight: AppTextStyle.regular,
        ),

        prefixIcon: prefixicon != null
            ? Padding(
                padding: EdgeInsets.only(left: 12, right: 8),
                child: prefixicon,
              )
            : null,
        prefixIconConstraints: BoxConstraints(minWidth: 18.w, minHeight: 18.w),
        suffixIcon: suffixicon != null
            ? Padding(
                padding: EdgeInsets.only(left: 8, right: 12),
                child: suffixicon,
              )
            : null,
        suffixIconConstraints: BoxConstraints(minWidth: 18.w, minHeight: 18.w),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColor.primary400),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColor.neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColor.neutral300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColor.danger500),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColor.danger500),
        ),
      ),
      validator: (value) {
        if (validator != null) {
          return validator(value);
        }
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  static Widget textFieldBlank({
    final String? label,
    final String? hintText,
    final Widget? prefixicon,
    final Widget? suffixicon,
    final TextEditingController? controller,
    final int? maxLines,
    final TextInputType? keyBoardType,
    final bool? enabled,
    String? Function(String?)? validator,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: AppTextStyle.body2(
              color: AppColor.neutral900,
              fontWeight: AppTextStyle.medium,
            ),
          ),
        SizedBox(height: 6.h),
        TextFormField(
          minLines: 1,
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyBoardType,
          enabled: enabled,

          style: AppTextStyle.body2(
            color: AppColor.neutral900,
            fontWeight: AppTextStyle.regular,
          ),
          decoration: InputDecoration(
            filled: false,
            fillColor: Colors.transparent,

            hintText: hintText,
            hintStyle: AppTextStyle.body2(
              color: AppColor.neutral400,
              fontWeight: AppTextStyle.regular,
            ),

            errorStyle: AppTextStyle.body2(
              color: AppColor.danger600,
              fontWeight: AppTextStyle.regular,
            ),

            prefixIcon: prefixicon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: prefixicon,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: 18.w,
              minHeight: 18.w,
            ),
            suffixIcon: suffixicon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 8, right: 12),
                    child: suffixicon,
                  )
                : null,
            suffixIconConstraints: BoxConstraints(
              minWidth: 18.w,
              minHeight: 18.w,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999.r),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999.r),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999.r),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999.r),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999.r),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          validator: (value) {
            if (validator != null) {
              return validator(value);
            }
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
