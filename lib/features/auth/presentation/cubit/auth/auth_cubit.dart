import 'package:bloc/bloc.dart';
import '../../../domain/usecases/auth_usecase_params.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUseCase;
  AuthCubit(this._loginUseCase) : super(AuthInitial());

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
