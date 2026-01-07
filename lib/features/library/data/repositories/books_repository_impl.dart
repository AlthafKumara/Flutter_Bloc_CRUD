import 'package:crud_clean_bloc/features/library/data/models/create_books_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/delete_book_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/upload_book_cover_model.dart';

import '../../../../core/errors/exception.dart';
import '../../domain/usecases/usecase_params.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_checker.dart';
import '../datasources/book_local_datasource.dart';
import '../datasources/book_remote_datasource.dart';

import '../../domain/entities/book_entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/book_repository.dart';

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
  Future<Either<Failure, void>> addBook(CreateBookParams params) async {
    try {
      final model = CreateBooksModel(
        title: params.title,
        author: params.author,
        createdAt: DateTime.now(),
        description: params.description,
        coverUrl: params.coverUrl,
      );

      final result = await bookRemoteDatasource.createBook(model);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Gagal menambahkan buku'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBook(DeleteBookParams params) async {
    try {
      final model = DeleteBookModel(id: params.id, coverUrl: params.coverUrl);

      final result = await bookRemoteDatasource.deleteBook(model);

      return Right(result);
    } on ServerException catch (e) {
      print(e.message);
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Gagal menghapus buku'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() {
    return networkInfo.check(
      connected: () async {
        try {
          final listbook = await bookRemoteDatasource.getBooks();
          // await localStorage.save(
          //   key: "library",
          //   boxName: "book",
          //   value: listbook,
          // );

          return Right(listbook);
        } on ServerException catch (e) {
          return Left(ServerFailure(e.message));
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      },
      notConnected: () async {
        try {
          final listbook = await bookLocalDatasource.getBooks();
          return Right(listbook);
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> updateBook(UpdateBookParams params) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadBookCover(
    UploadBookCoverParams params,
  ) async {
    try {
      final model = UploadBookCoverModel(
        title: params.title,
        cover: params.file,
      );

      final result = await bookRemoteDatasource.uploadBookCover(model);
      print(result);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Gagal menambahkan buku'));
    }
  }
}
