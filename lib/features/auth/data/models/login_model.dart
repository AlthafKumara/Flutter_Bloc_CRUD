import '../../domain/entities/auth_entity.dart';

class LoginModel extends AuthEntity {
  LoginModel({required super.email, required super.password});

  factory LoginModel.fromMap(Map<String, dynamic> map) =>
      LoginModel(email: map['email'], password: map['password']);

  Map<String, dynamic> toMap() => {'email': email, 'password': password};
}
