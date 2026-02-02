

import 'dart:io';

import '../../../domain/entities/book_entity.dart';

class UploadBookCoverModel extends BookEntity {
  final File cover;

  UploadBookCoverModel({required super.title,required super.id, required this.cover});

  factory UploadBookCoverModel.fromJson(Map<String, dynamic> json) {
    return UploadBookCoverModel(title: json['title'], cover: json['cover_url'], id: json['id']);
  }

  Map<String, dynamic> toMap() => {'title': title, 'cover_url': cover, 'id': id};
}
