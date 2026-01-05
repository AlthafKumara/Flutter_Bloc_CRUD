import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/book_repository.dart';

class CreateBookUsecase implements UseCase<void, Params> {
  final BookRepository _repository;

  CreateBookUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _repository.addBook(params);
  }
}

class Params extends Equatable {
  final String title;
  final String description;
  final String author;
  final File photoFile;

  Params({
    required this.title,
    required this.description,
    required this.author,
    required this.photoFile,
  });

  @override
  List<Object?> get props => [title, description, author, photoFile];
}
