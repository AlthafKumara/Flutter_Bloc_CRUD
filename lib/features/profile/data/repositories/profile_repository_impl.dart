import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/profile_remote_datasource.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;

  ProfileRepositoryImpl(this.profileRemoteDatasource);
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final profile = await profileRemoteDatasource.getProfile();
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
