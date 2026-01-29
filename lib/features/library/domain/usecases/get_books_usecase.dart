import '../../data/models/local/local_book_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/book_repository.dart';

class GetBooksUseCase implements UseCase<List<LocalBookModel>, NoParams> {
  final BookRepository _repository;
  const GetBooksUseCase(this._repository);

  @override
  Future<Either<Failure, List<LocalBookModel>>> call(NoParams params) async {
    return await _repository.getBooks();
  }
}
