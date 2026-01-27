import 'package:crud_clean_bloc/features/library/data/models/create_books_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/delete_book_model.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exception.dart';
import '../models/get_books_model.dart';

sealed class BookLocalDatasource {
  Future<void> createBook(CreateBooksModel model);

  Future<void> deleteBook(DeleteBookModel model);
  Future<void> updateAfterSync(GetBooksModel model);
  Future<List<GetBooksModel>> getBooks();
  Future<GetBooksModel> getBookById(int id);
  Future<List<GetBooksModel>> getBooksUnsynced();
}

class BookLocalDatasourceImpl implements BookLocalDatasource {
  final LocalStorage localStorage;

  BookLocalDatasourceImpl({required this.localStorage});
  @override
  Future<void> createBook(CreateBooksModel model) async {
    try {
      await localStorage.save(
        key: model.localId!.toString(),
        boxName: "book",
        value: model.toLocalMap(),
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<List<GetBooksModel>> getBooks() async {
    try {
      final response = await localStorage.loadAll(boxName: "book");

      if (response == null) throw CacheException('Data buku tidak ditemukan');

      return response.map<GetBooksModel>((e) {
        final map = Map<String, dynamic>.from(e as Map);
        return GetBooksModel.fromLocalMap(map);
      }).toList();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<GetBooksModel> getBookById(int id) async {
    try {
      final response = await localStorage.load(
        key: id.toString(),
        boxName: "book",
      );

      return GetBooksModel.fromLocalMap(response as Map<String, dynamic>);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<List<GetBooksModel>> getBooksUnsynced() async {
    final books = await getBooks();
    return books.where((b) => !b.isSynced!).toList();
  }

  @override
  Future<void> updateAfterSync(GetBooksModel model) async {
    final updatedMap = model
        .copyWith(
          isSynced: true,
          serverId: model.serverId,
          coverUrl: model.coverUrl,
        )
        .toLocalMap();

    await localStorage.save(
      key: model.localId!.toString(),
      boxName: "book",
      value: updatedMap,
    );
  }

  @override
  Future<void> deleteBook(DeleteBookModel model) async {
    try {
      final data = DeleteBookModel(id: model.id, coverUrl: model.coverUrl);

      return await localStorage.delete(
        key: data.id.toString(),
        boxName: "book",
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
