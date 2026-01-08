import 'package:equatable/equatable.dart';

class AuthLoginFormState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordHidden;
  const AuthLoginFormState({
    this.email = '',
    this.password = "",
    this.isPasswordHidden = true,
  });

  AuthLoginFormState copyWith({
    String? email,
    String? password,
    bool? isPasswordHidden,
  }) {
    return AuthLoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }

  @override
  List<Object?> get props => [email, password, isPasswordHidden];
}
