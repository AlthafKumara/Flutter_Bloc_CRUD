import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../usecases/auth_usecase_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(LoginParams params);
}