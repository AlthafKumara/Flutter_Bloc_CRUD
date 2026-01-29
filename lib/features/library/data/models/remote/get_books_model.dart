// ignore_for_file: annotate_overrides

import '../../../domain/entities/book_entity.dart';

class GetBooksModel extends BookEntity {
  final int id;
  final String title;
  final String author;
  final String description;
  final DateTime createdAt;
  String? coverUrl;
  

  GetBooksModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.author,
    this.coverUrl,
  }) : super(
         id: id,
         title: title,
         description: description,
         author: author,
         coverUrl: coverUrl,
       );

  factory GetBooksModel.fromLocalMap(Map<String, dynamic> map) {
    return GetBooksModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
      coverUrl: map['cover_url'],
      
    );
  }

  factory GetBooksModel.fromRemoteJson(Map<String, dynamic> json) {
    return GetBooksModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      coverUrl: json['cover_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  static List<GetBooksModel> fromMapLocalList(List<dynamic> mapList) {
    return mapList.map((json) => GetBooksModel.fromLocalMap(json)).toList();
  }

  static List<GetBooksModel> fromJsonRemoteList(List<dynamic> mapList) {
    return mapList.map((json) => GetBooksModel.fromRemoteJson(json)).toList();
  }

  Map<String, dynamic> toLocalMap() {
    return {
      'id' : id,
      'title': title,
      'author': author,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'cover_url': coverUrl,
    };
  }

  static List<Map<String, dynamic>> toLocalMapList(List<GetBooksModel> books) {
    return books.map((e) => e.toLocalMap()).toList();
  }

  GetBooksModel copyWith({
    int? id,
    String? title,
    String? author,
    String? description,
    String? coverPath,
    String? coverUrl,
    bool? isSynced,
  }) {
    return GetBooksModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      createdAt: createdAt,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }
}
