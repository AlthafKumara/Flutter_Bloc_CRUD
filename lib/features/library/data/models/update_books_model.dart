import 'package:crud_clean_bloc/features/library/domain/entities/book_entity.dart';

class UpdateBooksModel extends BookEntity {
  UpdateBooksModel({
    required super.id,
    super.title,
    super.author,
    super.description,

    super.coverUrl,
  });

  factory UpdateBooksModel.fromJson(Map<String, dynamic> json) {
    return UpdateBooksModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      coverUrl: json['cover_url'],
    );
  }
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'author': author,
    'description': description,
    'cover_url': coverUrl,
  };
}
