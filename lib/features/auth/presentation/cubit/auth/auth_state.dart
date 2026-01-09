part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// =========================== SPLASH ================================

class SplashLoadingState extends AuthState {}
class SplashSuccessState extends AuthState {}

// =========================== LOGIN ================================

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String message;
  const LoginSuccessState(this.message);
  @override
  List<Object> get props => [message];
}

class LoginErrorState extends AuthState {
  final String message;
  const LoginErrorState(this.message);
  @override
  List<Object> get props => [message];
}
