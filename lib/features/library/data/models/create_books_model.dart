// ignore_for_file: annotate_overrides

import '../../domain/entities/book_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'create_books_model.g.dart';

@HiveType(typeId: 1)
class CreateBooksModel extends BookEntity {
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

  CreateBooksModel({
    this.serverId,
    this.localId,
    required this.title,
    required this.author,
    required this.description,
    required this.createdAt,
    this.coverPath,
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

  CreateBooksModel copyWith({
    int? serverId,
    int? localId,
    String? coverPath,
    String? coverUrl,
    bool? isSynced,
  }) {
    return CreateBooksModel(
      serverId: serverId ?? this.serverId,
      localId: localId ?? this.localId,
      title: title,
      author: author,
      description: description,
      createdAt: createdAt,
      coverPath: coverPath ?? this.coverPath,
      coverUrl: coverUrl ?? this.coverUrl,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  Map<String, dynamic> toRemoteMap() => {
    'title': title,
    'author': author,
    'description': description,
    'created_at': createdAt.toIso8601String(),
    'cover_url': coverUrl,
  };

  Map<String, dynamic> toLocalMap() => {
    'server_id': serverId,
    'local_id': localId,
    'title': title,
    'author': author,
    'description': description,
    'created_at': createdAt.toIso8601String(),
    'cover_path': coverPath,
    'cover_url': coverUrl,
    'is_synced': isSynced,
  };
}
