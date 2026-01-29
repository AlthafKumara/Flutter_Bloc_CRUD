import '../../../domain/entities/book_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'local_book_model.g.dart';

@HiveType(typeId: 5)
class LocalBookModel extends BookEntity {
  @override
  @HiveField(0)
  String? title;
  @override
  @HiveField(1)
  String? author;
  @override
  @HiveField(2)
  String? description;
  @override
  @HiveField(3)
  DateTime? createdAt;
  @HiveField(4)
  int? serverId;
  @HiveField(5)
  int? localId;
  @HiveField(6)
  String? coverPath;
  @override
  @HiveField(7)
  String? coverUrl;
  @HiveField(8)
  bool? isSynced;
  @HiveField(9)
  bool? markAsDeleted;

  LocalBookModel({
    this.serverId,
    this.localId,
    this.title,
    this.description,
    this.createdAt,
    this.author,
    this.coverPath,
    this.isSynced = false,
    this.markAsDeleted = false,
    this.coverUrl,
  }) : super(
         id: serverId,
         title: title,
         description: description,
         author: author,
         coverUrl: coverUrl,
       );

  factory LocalBookModel.fromLocalMap(Map<String, dynamic> map) {
    return LocalBookModel(
      serverId: map['server_id'],
      localId: map['local_id'],
      title: map['title'],
      author: map['author'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
      coverPath: map['cover_path'],
      coverUrl: map['cover_url'],
      isSynced: map['is_synced'],
      markAsDeleted: map['mark_as_deleted'],
    );
  }

  factory LocalBookModel.fromRemoteJson(Map<String, dynamic> json) {
    return LocalBookModel(
      serverId: json['id'],
      localId: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      coverUrl: json['cover_url'],
      coverPath: json['cover_path'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      isSynced: true,
      markAsDeleted: false,
    );
  }

  static List<LocalBookModel> fromMapLocalList(List<dynamic> mapList) {
    return mapList.map((json) => LocalBookModel.fromLocalMap(json)).toList();
  }

  static List<LocalBookModel> fromJsonRemoteList(List<dynamic> mapList) {
    return mapList.map((json) => LocalBookModel.fromRemoteJson(json)).toList();
  }

  Map<String, dynamic> toLocalMap() {
    return {
      'local_id': localId,
      'server_id': serverId,
      'title': title,
      'author': author,
      'description': description,
      'created_at': createdAt!.toIso8601String(),
      'cover_path': coverPath,
      'cover_url': coverUrl,
      'is_synced': isSynced ?? false,
      "mark_as_deleted": markAsDeleted ?? false,
    };
  }

  static List<Map<String, dynamic>> toLocalMapList(List<LocalBookModel> books) {
    return books.map((e) => e.toLocalMap()).toList();
  }

  LocalBookModel copyWith({
    int? serverId,
    int? localId,
    String? title,
    String? author,
    String? description,
    String? coverPath,
    String? coverUrl,
    bool? isSynced,
    bool? markAsDeleted,
  }) {
    return LocalBookModel(
      serverId: serverId ?? this.serverId,
      localId: localId ?? this.localId,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      createdAt: createdAt,
      coverPath: coverPath ?? this.coverPath,
      coverUrl: coverUrl ?? this.coverUrl,
      isSynced: isSynced ?? this.isSynced,
      markAsDeleted: markAsDeleted ?? this.markAsDeleted,
    );
  }

  @override
  String toString() {
    return "GetBooksModel{serverId: $serverId, localId: $localId, title: $title, author: $author, description: $description, createdAt: $createdAt, coverUrl: $coverUrl, coverPath: $coverPath, isSynced: $isSynced, markAsDeleted: $markAsDeleted}";
  }
}
