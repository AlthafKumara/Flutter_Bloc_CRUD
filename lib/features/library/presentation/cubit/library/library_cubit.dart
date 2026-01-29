import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../../data/models/local/local_book_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/create_book_usecase.dart';
import '../../../domain/usecases/delete_books_usecase.dart';
import '../../../domain/usecases/get_books_usecase.dart';
import '../../../domain/usecases/update_book_usecase.dart';
import '../../../domain/usecases/upload_book_cover_usecase.dart';
import '../../../domain/usecases/usecase_params.dart';

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

  List<LocalBookModel> allbooks = [];

  // ================= GET ALL BOOK =================
  Future<void> getAllBooks() async {
    emit(GetAllBookLoadingState());

    final result = await _getBooksUseCase.call(NoParams());

    result.fold(
      (failure) => emit(GetAllBookErrorState(failure.message.toString())),
      (books) {
        allbooks = books;
        emit(GetAllBookSuccessState(books));
      },
    );
  }

  void searchBooks(String keyword) {
    if (keyword.isEmpty) {
      emit(GetAllBookSuccessState(allbooks));
      return;
    }

    final lower = keyword.toLowerCase();

    final filtered = allbooks.where((book) {
      return book.title!.toLowerCase().contains(lower) ||
          book.author!.toLowerCase().contains(lower);
    }).toList();

    emit(GetAllBookSuccessState(filtered));
  }

  // ================= CREATE BOOK + COVER =================
  Future<void> createBookWithCover({
    required String title,
    required String author,
    required String description,
    required String coverPath,
    required File coverFile,
  }) async {
    emit(CreateBookLoadingState());

    coverPath = coverFile.path;
    final createResult = await _createBookUsecase.call(
      CreateBookParams(
        title: title,
        author: author,
        description: description,
        coverPath: coverPath,
        coverUrl: "",
      ),
    );
    log("coverPath : $coverPath");

    createResult.fold(
      (failure) => emit(CreateBookErrorState(failure.message.toString())),
      (_) => emit(CreateBookSuccessState("Buku berhasil ditambahkan")),
    );
  }

  Future<void> updateBookWithOptionalCover({
    required int localId,
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
        localId: localId,
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

  Future<void> deleteBook({required int localId,String? coverUrl}) async {
    emit(DeleteBookLoadingState());

    final result = await _deleteBooksUsecase.call(
      DeleteBookParams(localId: localId, coverUrl: coverUrl),
    );

    result.fold(
      (failure) => emit(DeleteBookErrorState(failure.message.toString())),
      (_) => emit(DeleteBookSuccessState("Buku berhasil dihapus")),
    );
  }
}
