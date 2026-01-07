import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exception.dart';
import '../models/get_books_model.dart';

sealed class BookLocalDatasource {
  Future<List<GetBooksModel>> getBooks();
}

class BookLocalDatasourceImpl implements BookLocalDatasource {
  final LocalStorage localStorage;

  BookLocalDatasourceImpl({required this.localStorage});
  @override
  Future<List<GetBooksModel>> getBooks() => _getBooksFromCache();

  Future<List<GetBooksModel>> _getBooksFromCache() async {
    try {
      final response = await localStorage.load(key: "library", boxName: "book");

      if (response == null) throw CacheException('Data buku tidak ditemukan');
      if (response is! List) throw CacheException('Data buku tidak valid');

      final List<Map<String, dynamic>> safeList = response
          .map<Map<String, dynamic>>((e) {
            return Map<String, dynamic>.from(e as Map);
          })
          .toList();

      return GetBooksModel.fromJsonList(safeList);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
