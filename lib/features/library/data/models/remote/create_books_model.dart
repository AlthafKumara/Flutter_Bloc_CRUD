// ignore_for_file: annotate_overrides

import '../../../domain/entities/book_entity.dart';

class CreateBooksModel extends BookEntity {
  int? id;
  String? title;
  String? author;
  String? description;
  DateTime? createdAt;
  String? coverUrl;
  bool? isSynced;

  CreateBooksModel({
    this.id,
    this.title,
    this.author,
    this.description,
    this.createdAt,
    this.isSynced = false,
    this.coverUrl,
  }) : super(
         author: author,
         title: title,
         description: description,
         createdAt: createdAt,
         coverUrl: coverUrl,
       );

  factory CreateBooksModel.fromLocalMap(Map<String, dynamic> map) {
    return CreateBooksModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
      coverUrl: map['cover_url'],
      isSynced: map['is_synced'],
    );
  }

  CreateBooksModel copyWith({
    int? id,
    String? coverPath,
    String? coverUrl,
    bool? isSynced,
  }) {
    return CreateBooksModel(
      id: id ?? this.id,
      title: title,
      author: author,
      description: description,
      createdAt: createdAt,
      coverUrl: coverUrl ?? this.coverUrl,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  Map<String, dynamic> toRemoteMap() => {
    'title': title,
    'author': author,
    'description': description,
    'created_at': createdAt!.toIso8601String(),
    'cover_url': coverUrl,
  };

  Map<String, dynamic> toLocalMap() => {
    'id': id,
    'title': title,
    'author': author,
    'description': description,
    'created_at': createdAt!.toIso8601String(),
    'cover_url': coverUrl,
    'is_synced': isSynced,
  };
}
