import 'package:equatable/equatable.dart';

enum Role { admin, user }

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String role;
  final String email;
  final String? photoProfile;
  final String? gender;
  final String createdAt;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.photoProfile,
    this.gender,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [
    id,
    name,
    role,
    email,
    photoProfile,
    gender,
    createdAt,
  ];
}
