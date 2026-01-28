import 'dart:developer';

import 'package:crud_clean_bloc/core/service/sync_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_checker.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecases/usecase_params.dart';
import '../datasources/book_local_datasource.dart';
import '../datasources/book_remote_datasource.dart';
import '../models/create_books_model.dart';
import '../models/delete_book_model.dart';
import '../models/get_books_model.dart';
import '../models/upload_book_cover_model.dart';

class BooksRepositoryImpl implements BookRepository {
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;
  final BookLocalDatasource bookLocalDatasource;
  final BookRemoteDatasource bookRemoteDatasource;

  final SyncService syncService;

  BooksRepositoryImpl(
    this.localStorage,
    this.networkInfo,
    this.bookLocalDatasource,
    this.bookRemoteDatasource,
    this.syncService,
  );
  @override
  Future<Either<Failure, void>> addBook(CreateBookParams params) async {
    try {
      final model = CreateBooksModel(
        localId: DateTime.now().microsecondsSinceEpoch,
        title: params.title,
        author: params.author,
        createdAt: DateTime.now(),
        description: params.description,
        coverPath: params.coverPath,
        coverUrl: null,
        isSynced: false,
        serverId: null,
      );

      final result = await bookLocalDatasource.createBook(model);

      if (networkInfo.isConnected) {
        await syncService.syncBook();
      }

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
      final localData = await bookLocalDatasource.getBookById(params.localId);

      await bookLocalDatasource.deleteBook(
        DeleteBookModel(id: params.localId, coverUrl: params.coverUrl),
      );

      if (localData.serverId != null) {
        await bookRemoteDatasource.deleteBook(
          DeleteBookModel(
            id: localData.serverId!,
            coverUrl: localData.coverUrl!,
          ),
        );
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure('Gagal menghapus buku'));
    }
  }

  @override
  Future<Either<Failure, List<GetBooksModel>>> getBooks() {
    return networkInfo.check(
      connected: () async {
        try {
          final remoteBooks = await bookRemoteDatasource.getBooks();
          final localBooks = await bookLocalDatasource.getBooks();

          final Map<int, GetBooksModel> localByServerId = {
            for (final b in localBooks)
              if (b.serverId != null) b.serverId!: b,
          };

          for (final remote in remoteBooks) {
            final existingLocal = localByServerId[remote.serverId];

            final localId =
                existingLocal?.localId ?? DateTime.now().microsecondsSinceEpoch;

            final model = GetBooksModel(
              serverId: remote.serverId,
              localId: localId,
              title: remote.title,
              author: remote.author,
              description: remote.description,
              createdAt: remote.createdAt,
              coverUrl: remote.coverUrl,
              coverPath: null,
              isSynced: true,
            );

            await localStorage.save(
              key: localId.toString(),
              boxName: "book",
              value: model.toLocalMap(),
            );
          }

          final localBook = await bookLocalDatasource.getBooks();
          log(localBook.toString());
          return Right(localBook);
        } on ServerException catch (e) {
          return Left(ServerFailure(e.message));
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      },
      notConnected: () async {
        try {
          final listbook = await bookLocalDatasource.getBooks();
          log(listbook.toString());
          return Right(listbook);
        } on CacheException catch (e) {
          log(e.message.toString());
          return Left(CacheFailure(e.message));
        } catch (_) {
          return const Left(CacheFailure('Gagal mengupdate buku'));
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> updateBook(UpdateBookParams params) async {
    try {
      final oldBook = await bookLocalDatasource.getBookById(params.localId);

      final updateBook = oldBook.copyWith(
        title: params.title,
        author: params.author,
        description: params.description,
        coverUrl: params.coverUrl,
        isSynced: false,
      );

      final result = await bookLocalDatasource.updateBook(updateBook);

      if (networkInfo.isConnected) {
        await syncService.syncBook();
      }
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Gagal mengupdate buku'));
    }
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

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Gagal menambahkan buku'));
    }
  }
}
