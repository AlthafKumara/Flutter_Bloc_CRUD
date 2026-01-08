import '../../../../core/errors/exception.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_usecase_params.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl( this.authRemoteDatasource);
  @override
  Future<Either<Failure, void>> login(LoginParams params) async {
    try {
      final model = LoginModel(email: params.email, password: params.password);

      final result = await authRemoteDatasource.login(model);

      return Right(result);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Gagal login'));
    }
  }
}
