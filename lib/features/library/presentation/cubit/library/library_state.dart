part of 'library_cubit.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

//  ============================ GET ALL BOOK ==================================
class GetAllBookLoadingState extends LibraryState {}

class GetAllBookSuccessState extends LibraryState {
  final List<BookEntity> books;
  const GetAllBookSuccessState(this.books);
  @override
  List<Object> get props => [books];
}

class GetAllBookErrorState extends LibraryState {
  final String message;
  const GetAllBookErrorState(this.message);
  @override
  List<Object> get props => [message];
}

//  ============================ CREATE NEW BOOK ===============================

class CreateBookLoadingState extends LibraryState {}

class CreateBookSuccessState extends LibraryState {}

class CreateBookErrorState extends LibraryState {
  final String message;
  const CreateBookErrorState(this.message);
  @override
  List<Object> get props => [message];
}

//  ============================ UPLOAD COVER ===============================

class UploadBookCoverLoadingState extends LibraryState {}

class UploadBookCoverSuccessState extends LibraryState {}

class UploadBookCoverErrorState extends LibraryState {
  final String message;

  const UploadBookCoverErrorState(this.message);

  @override
  List<Object> get props => [message];
}

//  ============================ DELETE BOOK ===============================

class DeleteBookLoadingState extends LibraryState {}

class DeleteBookSuccessState extends LibraryState {
  final String message;
  const DeleteBookSuccessState(this.message);
  @override
  List<Object> get props => [message];
}

class DeleteBookErrorState extends LibraryState {
  final String message;
  const DeleteBookErrorState(this.message);
  @override
  List<Object> get props => [message];
}
