import 'package:dartz/dartz.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_checker.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_local_datasource.dart';
import '../datasources/book_remote_datasource.dart';

class BooksRepositoryImpl implements BookRepository {
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;
  final BookLocalDatasource bookLocalDatasource;
  final BookRemoteDatasource bookRemoteDatasource;

  BooksRepositoryImpl(
    this.localStorage,
    this.networkInfo,
    this.bookLocalDatasource,
    this.bookRemoteDatasource,
  );
  @override
  Future<Either<Failure, BookEntity>> addBook(BookEntity book) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> deleteBook(List<int> ids) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() {
    return networkInfo.check(
      connected: () async {
        try {
          final listbook = await bookRemoteDatasource.getBooks();
          await localStorage.save(
            key: "library",
            boxName: "book",
            value: listbook,
          );

          return Right(listbook);
        } catch (e) {
          return Left(ServerFailure());
        }
      },
      notConnected: () async {
        try {
          final listbook = await bookLocalDatasource.getBooks();
          return Right(listbook);
        } catch (e) {
          return Left(ServerFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, BookEntity>> updateBook(BookEntity book, int id) {
    throw UnimplementedError();
  }
}
