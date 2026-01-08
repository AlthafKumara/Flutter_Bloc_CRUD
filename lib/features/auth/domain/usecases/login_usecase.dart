import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase implements UseCase<void, Params> {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _repository.login(params);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
