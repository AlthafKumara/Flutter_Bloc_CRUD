import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud_clean_bloc/features/library/data/models/remote/delete_cover_book_model.dart';

import '../../features/library/data/datasources/book_local_datasource.dart';
import '../../features/library/data/datasources/book_remote_datasource.dart';
import '../../features/library/data/models/remote/create_books_model.dart';
import '../../features/library/data/models/remote/delete_book_model.dart';
import '../../features/library/data/models/remote/update_books_model.dart';
import '../../features/library/data/models/remote/upload_book_cover_model.dart';

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
      if (book.serverId == null && book.markAsDeleted == false) {
        log("Create Dijalankan");
        try {
          final coverUrl = await bookRemoteDatasource.uploadBookCover(
            UploadBookCoverModel(
              id: book.localId,
              title: book.title,
              cover: File(book.coverPath!),
            ),
          );

          final uploadBook = await bookRemoteDatasource.createBook(
            CreateBooksModel(
              title: book.title,
              author: book.author,
              createdAt: book.createdAt,
              description: book.description,
              coverUrl: coverUrl,
            ),
          );

          final syncBook = book.copyWith(
            serverId: uploadBook.id,
            coverUrl: coverUrl,
            isSynced: true,
          );

          await bookLocalDatasource.updateAfterSync(syncBook);
        } catch (e) {
          log(e.toString());
        }
      } else if (book.serverId != null && book.markAsDeleted == false) {
        // ============================ Update ==================================
        log("Update Dijalankan");
        try {
          if (book.coverPath != null) {
            if (book.coverUrl != null) {
              await bookRemoteDatasource.deleteCoverBook(
                DeleteCoverBookModel(coverUrl: book.coverUrl!),
              );
            }

            final coverUrl = await bookRemoteDatasource.uploadBookCover(
              UploadBookCoverModel(
                id: book.localId,
                title: book.title,
                cover: File(book.coverPath!),
              ),
            );

            book.coverUrl = coverUrl;
          }

          await bookRemoteDatasource.updateBook(
            UpdateBooksModel(
              localId: book.localId,
              serverId: book.serverId,
              title: book.title!,
              author: book.author!,
              description: book.description!,
              coverUrl: book.coverUrl,
            ),
          );
          final syncBook = book.copyWith(isSynced: true);

          await bookLocalDatasource.updateAfterSync(syncBook);

          await CachedNetworkImage.evictFromCache(book.coverUrl!);
        } catch (e) {
          log(e.toString());
        }
      } else if (book.markAsDeleted == true) {
        // ============================ Delete ==================================
        log("Delete Dijalankan");
        try {
          if (book.serverId != null) {
            await bookRemoteDatasource.deleteBook(
              DeleteBookModel(id: book.serverId!, coverUrl: book.coverUrl!),
            );
          }
          await bookLocalDatasource.deleteBook(book);
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }
}
