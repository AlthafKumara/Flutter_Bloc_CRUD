import 'dart:developer';

import '../models/local/local_book_model.dart';
import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exception.dart';

sealed class BookLocalDatasource {
  Future<void> createBook(LocalBookModel model);
  Future<void> updateBook(LocalBookModel model);
  Future<void> deleteBook(LocalBookModel model);
  Future<void> updateAfterSync(LocalBookModel model);
  Future<List<LocalBookModel>> getBooks();
  Future<List<LocalBookModel>> getBooksForUi();
  Future<LocalBookModel> getBookById(int id);
  Future<List<LocalBookModel>> getBooksUnsynced();
}

class BookLocalDatasourceImpl implements BookLocalDatasource {
  final LocalStorage localStorage;

  BookLocalDatasourceImpl({required this.localStorage});
  @override
  Future<void> createBook(LocalBookModel model) async {
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
  Future<void> updateBook(LocalBookModel model) async {
    try {
      await localStorage.save(
        key: model.localId.toString(),
        boxName: 'book',
        value: model.toLocalMap(),
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<List<LocalBookModel>> getBooks() async {
    try {
      final response = await localStorage.loadAll(boxName: "book");

      if (response == null) throw CacheException('Data buku tidak ditemukan');

      log(response.toString());
      return response.map<LocalBookModel>((e) {
        final map = Map<String, dynamic>.from(e as Map);
        return LocalBookModel.fromLocalMap(map);
      }).toList();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<LocalBookModel> getBookById(int id) async {
    final response = await localStorage.load(
      key: id.toString(),
      boxName: "book",
    );

    return LocalBookModel.fromLocalMap(Map<String, dynamic>.from(response));
  }

  @override
  Future<List<LocalBookModel>> getBooksForUi() async {
    final books = await getBooks();
    return books.where((b) => !b.markAsDeleted!).toList();
  }

  @override
  Future<List<LocalBookModel>> getBooksUnsynced() async {
    final books = await getBooks();
    return books.where((b) => !b.isSynced!).toList();
  }

  @override
  Future<void> updateAfterSync(LocalBookModel model) async {
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
  Future<void> deleteBook(LocalBookModel model) async {
    try {
      final data = LocalBookModel(localId: model.localId);

      return await localStorage.delete(
        key: data.localId.toString(),
        boxName: "book",
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
