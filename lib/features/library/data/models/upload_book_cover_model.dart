import 'dart:io';

import 'package:crud_clean_bloc/features/library/domain/entities/book_entity.dart';

class UploadBookCoverModel extends BookEntity {
  final File cover;

  UploadBookCoverModel({required super.title, required this.cover});

  factory UploadBookCoverModel.fromJson(Map<String, dynamic> json) {
    return UploadBookCoverModel(title: json['title'], cover: json['cover_url']);
  }

  Map<String, dynamic> toMap() => {'title': title, 'cover_url': cover};
}
