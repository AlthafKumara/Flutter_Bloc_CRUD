import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/api/api_url.dart';
import '../../../../core/errors/exception.dart';
import '../models/remote/create_books_model.dart';
import '../models/remote/delete_book_model.dart';
import '../models/remote/get_books_model.dart';
import '../models/remote/update_books_model.dart';
import '../models/remote/upload_book_cover_model.dart';

sealed class BookRemoteDatasource {
  Future<List<GetBooksModel>> getBooks();
  Future<GetBooksModel> createBook(CreateBooksModel model);
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

      return GetBooksModel.fromJsonRemoteList(response);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<GetBooksModel> createBook(CreateBooksModel model) async {
    try {
      final response = await ApiUrl.book
          .insert(model.toRemoteMap())
          .select()
          .single();

      return GetBooksModel.fromRemoteJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBookCover(UploadBookCoverModel model) async {
    try {
      final file = model.cover;
      final fileExt = model.cover.path.split('.').last;
      final fileName = '${model.title}.$fileExt';
      await ApiUrl.bookStorage.upload(fileName, file);

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
      await ApiUrl.book.update(model.toRemoteMap()).inFilter("id", [
        model.serverId,
      ]);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteBook(DeleteBookModel model) async {
    try {
      String? coverUrl = model.coverUrl;

      if (coverUrl != null) {
        final uri = Uri.parse(coverUrl);
        final segments = uri.pathSegments;

        final pathRelative = segments.sublist(5).join('/');

        final decodedPath = Uri.decodeFull(pathRelative);

        await ApiUrl.bookStorage.remove([decodedPath]);
      }

      await ApiUrl.book.delete().inFilter("id", [model.id]);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
