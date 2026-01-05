import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/book_repository.dart';

class DeleteBooksUsecase implements UseCase<void, Params> {
  final BookRepository _repository;

  DeleteBooksUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _repository.deleteBook(params);
  }
}

class Params extends Equatable {
  final List<int> ids;

  const Params({required this.ids});
  @override
  List<Object?> get props => [ids];
}
