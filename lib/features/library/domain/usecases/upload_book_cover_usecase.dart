import 'dart:io';

import 'package:crud_clean_bloc/core/errors/failure.dart';
import 'package:crud_clean_bloc/core/usecases/usecase.dart';
import 'package:crud_clean_bloc/features/library/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UploadBookCoverUsecase implements UseCase<String, Params> {
  final BookRepository _repository;

  UploadBookCoverUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await _repository.uploadBookCover(params);
  }
}

class Params extends Equatable {
  final String title;
  final File file;

  const Params({required this.title, required this.file});

  @override
  List<Object?> get props => [title, file];
}
