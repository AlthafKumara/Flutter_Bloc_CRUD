import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class GetBooksUseCase implements UseCase<List<BookEntity>, NoParams> {
  final BookRepository _repository;
  const GetBooksUseCase(this._repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) async {
    return await _repository.getBooks();
  }
}
