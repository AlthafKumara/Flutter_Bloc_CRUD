import '../../domain/entities/book_entity.dart';

class CreateBooksModel extends BookEntity {
  CreateBooksModel({
    required super.title,
    required super.author,
    required super.description,
    required super.createdAt,
    required super.coverUrl,
  });

  factory CreateBooksModel.fromJson(Map<String, dynamic> json) {
    return CreateBooksModel(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      createdAt: json['created_at'],
      coverUrl: json['cover_url'],
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'author': author,
    'description': description,
    'created_at': createdAt?.toIso8601String(),
    'cover_url': coverUrl,
  };
}
