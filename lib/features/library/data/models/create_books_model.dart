import 'dart:io';

import '../../domain/entities/book_entity.dart';

class CreateBooksModel extends BookEntity {
  final File cover;
  CreateBooksModel({
    required super.title,
    required super.author,
    required super.description,
    required super.createdAt,
    required this.cover,
  });

  factory CreateBooksModel.fromJson(Map<String, dynamic> json) {
    return CreateBooksModel(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      createdAt: json['created_at'],
      cover: json['cover_url'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'author': author,
    'description': description,
    'created_at': createdAt,
    'cover_url': cover,
  };
}
