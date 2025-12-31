import 'package:crud_clean_bloc/core/api/api_url.dart';
import 'package:crud_clean_bloc/core/errors/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/get_books_model.dart';

sealed class BookRemoteDatasource {
  Future<List<GetBooksModel>> getBooks();
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
}
