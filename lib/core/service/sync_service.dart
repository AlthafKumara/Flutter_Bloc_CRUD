import 'dart:developer';
import 'dart:io';
import 'package:crud_clean_bloc/features/library/data/datasources/book_local_datasource.dart';
import 'package:crud_clean_bloc/features/library/data/datasources/book_remote_datasource.dart';
import 'package:crud_clean_bloc/features/library/data/models/create_books_model.dart';
import 'package:crud_clean_bloc/features/library/data/models/update_books_model.dart';
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
    final unsyncedBooks = await bookLocalDatasource.getBooksUnsynced();

    for (final book in unsyncedBooks) {
      // ============================ Create ==================================
      if (book.serverId == null) {
        log("Create Dijalankan");
        try {
          final coverUrl = await bookRemoteDatasource.uploadBookCover(
            UploadBookCoverModel(
              title: book.title,
              cover: File(book.coverPath!),
            ),
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
      } else {
        log("Update Dijalankan");
        try {
          await bookRemoteDatasource.updateBook(
            UpdateBooksModel(
              localId: book.localId,
              serverId: book.serverId,
              title: book.title,
              author: book.author,
              description: book.description,
              coverUrl: book.coverUrl,
            ),
          );
          final syncBook = book.copyWith(isSynced: true);

          await bookLocalDatasource.updateAfterSync(syncBook);
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }
}
