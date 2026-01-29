import '../../../domain/entities/book_entity.dart';

class UpdateBooksModel extends BookEntity {
  @override
  final String title;
  @override
  final String author;
  @override
  final String description;
  @override
  String? coverUrl;
  int? serverId;
  int? localId;

  bool? isSynced;

  UpdateBooksModel({
    this.serverId,
    this.localId,
    required this.title,
    required this.author,
    required this.description,

    this.isSynced = false,
    this.coverUrl,
  }) : super(
         author: author,
         title: title,
         description: description,
         coverUrl: coverUrl,
       );

  Map<String, dynamic> toLocalMap() => {
    'server_id': serverId,
    'local_id': localId,
    'title': title,
    'author': author,
    'description': description,
    'cover_url': coverUrl,
    'is_synced': isSynced,
  };

  Map<String, dynamic> toRemoteMap() => {
    'title': title,
    'author': author,
    'description': description,
    'cover_url': coverUrl,
  };
}
