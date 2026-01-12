import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/assets_constant.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';
import '../../../../routes/app_routes_path.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/login_flow/login_flow_cubit.dart';
import '../cubit/login_flow/login_flow_state.dart';
import '../widgets/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              CustomSnackbar.show(
                context,
                message: state.message,
                backgroundColor: AppColor.danger600,
              );
            } else if (state is LoginSuccessState) {
              context.read<LoginFlowCubit>().loginComplete();
              context.read<ProfileCubit>().getProfile();
            }
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is GetProfileErrorState) {
              CustomSnackbar.show(
                context,
                message: state.message,
                backgroundColor: AppColor.danger600,
              );
            } else if (state is GetProfileSuccessState) {
              context.read<LoginFlowCubit>().profileComplete(state.profile);
              ();
            }
          },
        ),

        BlocListener<LoginFlowCubit, LoginFlowState>(
          listener: (context, state) {
            if (state is LoginFlowSuccessState) {
              final profile = state.profile;
              CustomSnackbar.show(
                context,
                message: "Login Success, Selamat Datang ${profile.name}",
                backgroundColor: AppColor.success500,
              );

              context.goNamed(AppRoutes.libraryView.name);
            }
          },
        ),
      ],

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
