import 'package:crud_clean_bloc/core/errors/failure.dart';
import 'package:crud_clean_bloc/core/usecases/usecase.dart';
import 'package:crud_clean_bloc/features/library/domain/entities/book_entity.dart';
import 'package:crud_clean_bloc/features/library/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class GetBooksUseCase implements UseCase<List<BookEntity>, NoParams> {
  final BookRepository _repository;
  const GetBooksUseCase(this._repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) async {
    return await _repository.getBooks();
  }
}
