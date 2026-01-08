import 'package:bloc/bloc.dart';
import 'auth_login_form_state.dart';

class AuthLoginFormCubit extends Cubit<AuthLoginFormState> {
  AuthLoginFormCubit() : super(const AuthLoginFormState());
  
  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }
}