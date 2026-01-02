import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, BookEntity>> addBook(BookEntity book);
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, BookEntity>> updateBook(BookEntity book, int id);
  Future<Either<Failure, List<BookEntity>>> deleteBook(List<int> ids);
}
