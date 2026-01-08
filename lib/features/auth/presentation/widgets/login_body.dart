import '../cubit/auth/auth_cubit.dart';
import '../cubit/auth_login_form/auth_login_form_cubit.dart';
import '../cubit/auth_login_form/auth_login_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets_constant.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';
import '../../../../core/utils/validator.dart';
import '../../../../widgets/button_large.dart';
import '../../../../widgets/textfield.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final validator = Validator();
  final loginFormKey = GlobalKey<FormState>();

  void login(BuildContext context) async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    } else {
      context.read<AuthCubit>().login(
        email: context.read<AuthLoginFormCubit>().state.email,
        password: context.read<AuthLoginFormCubit>().state.password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 40.h, horizontal: 16.w),
        child: BlocBuilder<AuthLoginFormCubit, AuthLoginFormState>(
          builder: (context, state) {
            return Form(
              key: loginFormKey,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back",
                            style: AppTextStyle.heading3(
                              color: AppColor.neutral900,
                              fontWeight: AppTextStyle.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "You can log into your account first to read many interesting books!",
                            style: AppTextStyle.description2(
                              color: AppColor.neutral400,
                              fontWeight: AppTextStyle.medium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      CustomTextfield.textFieldLarge(
                        prefixicon: Image.asset(Assets.iconEmail, width: 20.w),
                        label: "Email",
                        hintText: "youremail@gmail.com",
                        onChanged: context
                            .read<AuthLoginFormCubit>()
                            .onEmailChanged,
                        isObsecureText: false,
                        maxLines: 1,
                        keyBoardType: TextInputType.emailAddress,
                        enabled: true,
                        validator: validator.validatorEmail,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextfield.textFieldLarge(
                        prefixicon: Image.asset(Assets.iconLock, width: 20.w),
                        suffixicon: GestureDetector(
                          onTap: () {
                            context
                                .read<AuthLoginFormCubit>()
                                .togglePasswordVisibility();
                          },
                          child: Image.asset(Assets.iconEye, width: 20.w),
                        ),
                        label: "Password",
                        hintText: "Input Your Password",
                        onChanged: context
                            .read<AuthLoginFormCubit>()
                            .onPasswordChanged,
                        isObsecureText: state.isPasswordHidden,
                        maxLines: 1,
                        keyBoardType: TextInputType.visiblePassword,
                        enabled: true,
                        validator: validator.validatorPassword,
                      ),

                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: AppTextStyle.body2(
                              color: AppColor.neutral400,
                              fontWeight: AppTextStyle.medium,
                            ),
                          ),
                          Text(
                            " Reset Password",
                            style: AppTextStyle.body2(
                              color: AppColor.primary500,
                              fontWeight: AppTextStyle.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      CustomButtonLarge.primarylarge(
                        text: "Login",
                        onPressed: () {
                          login(context);
                        },
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
