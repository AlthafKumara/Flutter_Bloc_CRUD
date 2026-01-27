import 'package:crud_clean_bloc/features/library/data/models/get_books_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/book_repository.dart';

class GetBooksUseCase implements UseCase<List<GetBooksModel>, NoParams> {
  final BookRepository _repository;
  const GetBooksUseCase(this._repository);

  @override
  Future<Either<Failure, List<GetBooksModel>>> call(NoParams params) async {
    return await _repository.getBooks();
  }
}
