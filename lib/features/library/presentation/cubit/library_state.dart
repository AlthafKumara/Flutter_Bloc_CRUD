part of 'library_cubit.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

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
