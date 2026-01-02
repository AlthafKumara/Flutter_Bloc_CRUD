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

      return GetBooksModel.fromJsonList(response);
    } catch (e) {
      throw CacheException();
    }
  }
}
