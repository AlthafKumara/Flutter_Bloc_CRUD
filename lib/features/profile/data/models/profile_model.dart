// ignore_for_file: annotate_overrides

import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/profile_entity.dart';

part 'profile_model.g.dart';
@HiveType(typeId: 1)
class ProfileModel extends ProfileEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String role;
  @HiveField(4)
  final String createdAt;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  final String? photoProfile;
  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    this.gender,
    this.photoProfile,
  }) : super(
         id: id,
         name: name,
         email: email,
         role: role,
         createdAt: createdAt,
         gender: gender,
         photoProfile: photoProfile,
       );

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
