import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/book_repository.dart';

class UpdateBookUsecase implements UseCase<void, Params> {
  final BookRepository _repository;

  UpdateBookUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _repository.updateBook(params);
  }
}

class Params extends Equatable {
  final int id;
  final String title;
  final String description;
  final String author;
  File? photoFile;

  Params({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    this.photoFile,
  });
  @override
  List<Object?> get props => [id, title, description, author, photoFile];
}
