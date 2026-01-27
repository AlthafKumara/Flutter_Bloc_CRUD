import 'dart:developer';
import 'dart:io';
import 'package:crud_clean_bloc/features/library/data/datasources/book_local_datasource.dart';
import 'package:crud_clean_bloc/features/library/data/datasources/book_remote_datasource.dart';
import 'package:crud_clean_bloc/features/library/data/models/create_books_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/upload_book_cover_model.dart';

abstract class SyncService {
  Future<void> syncBook();
}

class SyncServiceImpl implements SyncService {
  final BookRemoteDatasource bookRemoteDatasource;
  final BookLocalDatasource bookLocalDatasource;

  SyncServiceImpl({
    required this.bookLocalDatasource,
    required this.bookRemoteDatasource,
  });
  @override
  Future<void> syncBook() async {
    log("DIJALANKAN");

    final unsyncedBooks = await bookLocalDatasource.getBooksUnsynced();

    for (final book in unsyncedBooks) {
      try {
        final coverUrl = await bookRemoteDatasource.uploadBookCover(
          UploadBookCoverModel(title: book.title, cover: File(book.coverPath!)),
        );

        final uploadBook = await bookRemoteDatasource.createBook(
          CreateBooksModel(
            localId: book.localId,
            title: book.title,
            author: book.author,
            createdAt: book.createdAt,
            description: book.description,
            coverPath: book.coverPath,
            coverUrl: coverUrl,
          ),
        );

        final syncBook = book.copyWith(
          serverId: uploadBook.serverId,
          coverUrl: coverUrl,
          isSynced: true,
        );

        await bookLocalDatasource.updateAfterSync(syncBook);
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
