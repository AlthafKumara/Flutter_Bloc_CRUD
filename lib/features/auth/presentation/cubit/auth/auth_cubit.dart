import 'package:bloc/bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../profile/domain/entities/profile_entity.dart';
import '../../../../profile/domain/usecases/get_profile_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/auth_usecase_params.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetProfileUsecase _getProfileUsecase;
  final LoginUsecase _loginUseCase;
  AuthCubit(this._loginUseCase, this._getProfileUsecase) : super(AuthInitial());

  Future<void> splashDelay() async {
    emit(SplashLoadingState());

    final result = await _getProfileUsecase.call(NoParams());

    result.fold(
      (_) => emit(UnAuthenticatedState()),
      (profile) => emit(AuthenticatedState(profile)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    final result = await _loginUseCase.call(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (l) => emit(LoginErrorState(l.message)),
      (r) => emit(LoginSuccessState("Berhasil login")),
    );
  }
}
