import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  String? userId;
  String? userName;
  final String email;
  final String password;

  AuthEntity({
    this.userId,
    this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, email, userName, password];
}
