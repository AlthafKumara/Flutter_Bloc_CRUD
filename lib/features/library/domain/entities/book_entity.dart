import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  int? id;
  String? title;
  String? author;
  String? description;
  String? coverUrl;
  DateTime? createdAt;

  BookEntity({
    this.id,
    this.title,
    this.author,
    this.description,
    this.coverUrl,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, author, description, coverUrl];
}
