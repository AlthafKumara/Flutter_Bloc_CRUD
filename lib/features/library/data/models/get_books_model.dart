import '../../domain/entities/book_entity.dart';

class GetBooksModel extends BookEntity {
  GetBooksModel({
    required super.id,
    required super.title,
    required super.description,
    required super.author,
    required super.coverUrl,
  });

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
