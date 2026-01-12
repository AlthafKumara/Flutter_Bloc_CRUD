import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.createdAt,
    super.gender,
    super.photoProfile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    role: json['role'],
    createdAt: json['created_at'],
    gender: json['gender'],
    photoProfile: json['photo_profile'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
    'created_at': createdAt,
    'gender': gender,
    'photo_profile': photoProfile,
  };
}
