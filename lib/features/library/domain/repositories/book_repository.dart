import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';
import '../usecases/usecase_params.dart';

abstract class BookRepository {
  Future<Either<Failure, void>> addBook(CreateBookParams params);
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, void>> updateBook(UpdateBookParams params);
  Future<Either<Failure, void>> deleteBook(DeleteBookParams params);
}
