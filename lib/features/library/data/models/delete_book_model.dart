class DeleteBookModel {
  final String coverUrl;
  final int id;

  DeleteBookModel({required this.id, required this.coverUrl});

  factory DeleteBookModel.fromJson(Map<String, dynamic> json) {
    return DeleteBookModel(id: json['id'], coverUrl: json['cover_url']);
  }

  Map<String, dynamic> toMap() => {'id': id, 'cover_url': coverUrl};
}
