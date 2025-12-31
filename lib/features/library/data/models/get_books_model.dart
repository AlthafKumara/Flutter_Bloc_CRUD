import '../../domain/entities/book_entity.dart';

class GetBooksModel extends BookEntity {
  GetBooksModel({
    required int id,
    required String title,
    required String description,
    required String author,
    required String coverUrl,
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
      coverUrl: json['coverUrl'],
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
      coverUrl: map['coverUrl'],
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
      'coverUrl': coverUrl,
    };
  }

  static List<Map<String, dynamic>> toMapList(List<GetBooksModel> books) {
    return books.map((book) => book.toMap()).toList();
  }
}
