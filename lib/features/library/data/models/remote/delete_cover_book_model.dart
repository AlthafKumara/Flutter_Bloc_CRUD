import 'package:crud_clean_bloc/features/library/domain/entities/book_entity.dart';

class DeleteCoverBookModel extends BookEntity {
  @override
  final String coverUrl;

  DeleteCoverBookModel({required this.coverUrl});
}
