import 'package:crud_clean_bloc/features/library/data/models/create_books_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/delete_book_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/update_books_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/upload_book_cover_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/api/api_url.dart';
import '../../../../core/errors/exception.dart';
import '../models/get_books_model.dart';

sealed class BookRemoteDatasource {
  Future<List<GetBooksModel>> getBooks();
  Future<void> createBook(CreateBooksModel model);
  Future<String> uploadBookCover(UploadBookCoverModel model);
  Future<void> deleteBook(DeleteBookModel model);
  Future<void> updateBook(UpdateBooksModel model);
}

class BookRemoteDatasourceImpl implements BookRemoteDatasource {
  BookRemoteDatasourceImpl();

  @override
  Future<List<GetBooksModel>> getBooks() async {
    try {
      final response = await ApiUrl.book.select();

      return GetBooksModel.fromJsonList(response);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createBook(CreateBooksModel model) async {
    try {
      await ApiUrl.book.insert(model.toMap());
      return;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBookCover(UploadBookCoverModel model) async {
    try {
      final fileExt = model.cover.path.split('.').last;
      final fileName = '${model.title}.$fileExt';
      await ApiUrl.bookStorage.upload(fileName, model.cover);

      final publicUrl = ApiUrl.bookStorage.getPublicUrl(fileName);
      return publicUrl;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateBook(UpdateBooksModel model) async {
    try {
      await ApiUrl.book.update(model.toMap()).inFilter("id", [model.id]);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteBook(DeleteBookModel model) async {
    try {
      String coverUrl = model.coverUrl;

      final uri = Uri.parse(coverUrl);
      final segments = uri.pathSegments;

      final pathRelative = segments.sublist(5).join('/');

      final decodedPath = Uri.decodeFull(pathRelative);

      await ApiUrl.bookStorage.remove([decodedPath]);

      await ApiUrl.book.delete().inFilter("id", [model.id]);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
