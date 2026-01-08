import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/usecases/delete_books_usecase.dart';
import '../../../domain/usecases/update_book_usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/create_book_usecase.dart';
import '../../../domain/usecases/upload_book_cover_usecase.dart';
import '../../../domain/usecases/usecase_params.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_books_usecase.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final GetBooksUseCase _getBooksUseCase;
  final CreateBookUsecase _createBookUsecase;
  final UploadBookCoverUsecase _uploadBookCoverUsecase;
  final DeleteBooksUsecase _deleteBooksUsecase;
  final UpdateBookUsecase _updateBookUsecase;

  LibraryCubit(
    this._getBooksUseCase,
    this._createBookUsecase,
    this._uploadBookCoverUsecase,
    this._deleteBooksUsecase,
    this._updateBookUsecase,
  ) : super(LibraryInitial());

  // ================= GET ALL BOOK =================
  Future<void> getAllBooks() async {
    emit(GetAllBookLoadingState());

    final result = await _getBooksUseCase.call(NoParams());

    result.fold(
      (failure) => emit(GetAllBookErrorState(failure.message.toString())),
      (books) => emit(GetAllBookSuccessState(books)),
    );
  }

  // ================= CREATE BOOK + COVER =================
  Future<void> createBookWithCover({
    required String title,
    required String author,
    required String description,
    required File coverFile,
  }) async {
    emit(CreateBookLoadingState());

    final uploadResult = await _uploadBookCoverUsecase.call(
      UploadBookCoverParams(title: title, file: coverFile),
    );

    await uploadResult.fold(
      (failure) async {
        emit(UploadBookCoverErrorState(failure.message.toString()));
      },
      (coverUrl) async {
        final createResult = await _createBookUsecase.call(
          CreateBookParams(
            title: title,
            author: author,
            description: description,
            coverUrl: coverUrl,
          ),
        );

        createResult.fold(
          (failure) => emit(CreateBookErrorState(failure.message.toString())),
          (_) => emit(CreateBookSuccessState(
            "Buku berhasil ditambahkan",
          )),
        );
      },
    );
  }

  Future<void> updateBookWithOptionalCover({
    required int id,
    required String title,
    required String author,
    required String description,
    required String oldCoverUrl,
    File? newCoverFile,
  }) async {
    emit(UpdateBookLoadingState());

    String coverUrl = oldCoverUrl;

    if (newCoverFile != null) {
      final uploadResult = await _uploadBookCoverUsecase.call(
        UploadBookCoverParams(title: title, file: newCoverFile),
      );

      final uploadEither = await uploadResult.fold((failure) async {
        emit(UploadBookCoverErrorState(failure.message));
        return null;
      }, (uploadedUrl) async => uploadedUrl);

      if (uploadEither == null) return;

      coverUrl = uploadEither;
    }

    final updateResult = await _updateBookUsecase.call(
      UpdateBookParams(
        id: id,
        title: title,
        author: author,
        description: description,
        coverUrl: coverUrl,
      ),
    );

    updateResult.fold(
      (failure) => emit(UpdateBookErrorState(failure.message)),
      (_) => emit(UpdateBookSuccessState("Buku berhasil diupdate")),
    );
  }

  Future<void> deleteBook({required int id, required String coverUrl}) async {
    
    emit(DeleteBookLoadingState());

    final result = await _deleteBooksUsecase.call(
      DeleteBookParams(id: id, coverUrl: coverUrl),
    );

    result.fold(
      (failure) => emit(DeleteBookErrorState(failure.message.toString())),
      (_) => emit(DeleteBookSuccessState("Buku berhasil dihapus")),
    );
  }
}
