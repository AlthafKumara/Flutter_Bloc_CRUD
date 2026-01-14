import 'package:crud_clean_bloc/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/assets_constant.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../routes/app_routes_path.dart';
import '../cubit/auth/auth_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          context.goNamed(AppRoutes.login.name);
        } else if (state is AuthenticatedState) {
          context.goNamed(AppRoutes.libraryView.name);
          CustomSnackbar.show(
            context,
            message: "Selamat datang ${state.profile.name}",
            backgroundColor: AppColor.success600,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.neutral100,
        body: Center(
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.logo),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
