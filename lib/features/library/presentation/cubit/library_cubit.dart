import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/usecases/get_books_usecase.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final GetBooksUseCase _getBooksUseCase;
  LibraryCubit(this._getBooksUseCase) : super(LibraryInitial());

  Future<void> getAllBooks() async {
    emit(GetAllBookLoadingState());

    final result = await _getBooksUseCase.call(NoParams());

    result.fold(
      (l) => emit(GetAllBookErrorState("Gagal Mengambil data")),
      (r) => emit(GetAllBookSuccessState(r)),
    );
  }
}
