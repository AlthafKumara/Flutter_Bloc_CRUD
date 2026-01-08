import '../../../../core/constants/assets_constant.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';
import '../cubit/auth/auth_cubit.dart';
import '../widgets/login_body.dart';
import '../../../../routes/app_routes_path.dart';
import '../../../../widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          CustomSnackbar.show(
            context,
            message: state.message,
            backgroundColor: AppColor.danger600,
          );
        } else if (state is LoginSuccessState) {
          CustomSnackbar.show(
            context,
            message: state.message,
            backgroundColor: AppColor.success600,
          );
          context.goNamed(AppRoutes.libraryView.name);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.neutral100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          backgroundColor: AppColor.neutral100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 26.w,
                height: 26.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                "Baca",
                style: AppTextStyle.heading4(
                  color: AppColor.neutral900,
                  fontWeight: AppTextStyle.semiBold,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: LoginBody(),
      ),
    );
  }
}
