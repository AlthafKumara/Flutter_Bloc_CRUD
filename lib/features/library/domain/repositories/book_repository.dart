import 'package:crud_clean_bloc/core/errors/failure.dart';
import 'package:crud_clean_bloc/features/library/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BookRepository {
  Future<Either<Failure, BookEntity>> addBook(BookEntity book);
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, BookEntity>> updateBook(BookEntity book, int id);
  Future<Either<Failure, List<BookEntity>>> deleteBook(List<int> ids);
}
