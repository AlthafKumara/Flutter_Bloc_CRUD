import 'package:crud_clean_bloc/features/library/data/models/get_books_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../usecases/usecase_params.dart';

abstract class BookRepository {
  Future<Either<Failure, void>> addBook(CreateBookParams params);
  Future<Either<Failure, List<GetBooksModel>>> getBooks();
  Future<Either<Failure, void>> updateBook(UpdateBookParams params);
  Future<Either<Failure, void>> deleteBook(DeleteBookParams params);
  Future<Either<Failure, String>> uploadBookCover(UploadBookCoverParams params);
}
