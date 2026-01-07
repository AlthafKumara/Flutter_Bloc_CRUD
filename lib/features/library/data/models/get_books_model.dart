// ignore_for_file: annotate_overrides

import 'package:hive_flutter/adapters.dart';

import '../../domain/entities/book_entity.dart';

part 'get_books_model.g.dart';
@HiveType(typeId: 0)
class GetBooksModel extends BookEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String author;

  @HiveField(4)
  final String coverUrl;
  GetBooksModel({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.coverUrl,
  }) : super(
    id: id,
    title: title,
    description: description,
    author: author,
    coverUrl: coverUrl,
  );

  factory GetBooksModel.fromJson(Map<String, dynamic> json) {
    return GetBooksModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      coverUrl: json['cover_url'],
    );
  }

  static List<GetBooksModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GetBooksModel.fromJson(json)).toList();
  }

  factory GetBooksModel.fromMap(Map<String, dynamic> map) {
    return GetBooksModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      author: map['author'],
      coverUrl: map['cover_url'],
    );
  }

  static List<GetBooksModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((json) => GetBooksModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author,
      'cover_url': coverUrl,
    };
  }

  static List<Map<String, dynamic>> toMapList(List<GetBooksModel> books) {
    return books.map((book) => book.toMap()).toList();
  }
}
