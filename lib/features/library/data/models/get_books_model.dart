// ignore_for_file: annotate_overrides

import 'package:hive_flutter/adapters.dart';

import '../../domain/entities/book_entity.dart';

part 'get_books_model.g.dart';

@HiveType(typeId: 0)
class GetBooksModel extends BookEntity {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  int? serverId;
  @HiveField(5)
  int? localId;
  @HiveField(6)
  String? coverPath;
  @HiveField(7)
  String? coverUrl;
  @HiveField(8)
  bool? isSynced;

  GetBooksModel({
    this.serverId,
    this.localId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.author,
    this.coverPath,
    this.isSynced = false,
    this.coverUrl,
  }) : super(
         id: serverId,
         title: title,
         description: description,
         author: author,
         coverUrl: coverUrl,
       );

  factory GetBooksModel.fromLocalMap(Map<String, dynamic> map) {
    return GetBooksModel(
      serverId: map['server_id'],
      localId: map['local_id'],
      title: map['title'],
      author: map['author'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
      coverPath: map['cover_path'],
      coverUrl: map['cover_url'],
      isSynced: map['is_synced'],
    );
  }

  factory GetBooksModel.fromRemoteJson(Map<String, dynamic> json) {
    return GetBooksModel(
      serverId: json['id'],
      localId: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      coverUrl: json['cover_url'],
      coverPath: json['cover_path'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      isSynced: true,
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
      'local_id': localId,
      'server_id': serverId,
      'title': title,
      'author': author,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'cover_path': coverPath,
      'cover_url': coverUrl,
      'is_synced': isSynced ?? false,
    };
  }

  static List<Map<String, dynamic>> toLocalMapList(List<GetBooksModel> books) {
    return books.map((e) => e.toLocalMap()).toList();
  }

  GetBooksModel copyWith({
    int? serverId,
    int? localId,
    String? title,
    String? author,
    String? description,
    String? coverPath,
    String? coverUrl,
    bool? isSynced,
  }) {
    return GetBooksModel(
      serverId: serverId ?? this.serverId,
      localId: localId ?? this.localId,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      createdAt: createdAt,
      coverPath: coverPath ?? this.coverPath,
      coverUrl: coverUrl ?? this.coverUrl,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  String toString() {
    return "GetBooksModel{serverId: $serverId, localId: $localId, title: $title, author: $author, description: $description, createdAt: $createdAt, coverUrl: $coverUrl, coverPath: $coverPath, isSynced: $isSynced}";
  }
}
