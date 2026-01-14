import 'package:dartz/dartz.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_checker.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;
  final ProfileLocalDatasource profileLocalDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(
    this.profileRemoteDatasource,
    this.profileLocalDataSource,
    this.localStorage,
    this.networkInfo,
  );
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    return networkInfo.check(
      connected: () async {
        try {
          final profileLocal = await profileLocalDataSource.getProfile();
          final profileRemote = await profileRemoteDatasource.getProfile();

          if (profileLocal == null || profileLocal.id != profileRemote.id) {
            await localStorage.save(
              key: "profile",
              boxName: "user",
              value: profileRemote,
            );
            return Right(profileRemote);
          }

          return Right(profileRemote);
        } on ServerException catch (e) {
          return Left(ServerFailure(e.message));
        } on CacheException catch (e) {
          return Left(CacheFailure(e.message));
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      },
      notConnected: () async {
        try {
          final profileLocal = await profileLocalDataSource.getProfile();

          if (profileLocal != null) {
            return Right(profileLocal);
          }

          return Left(CacheFailure('Profile Tidak ada di Local Storage'));
        } on CacheException catch (e) {
          return Left(CacheFailure(e.message));
        } catch (e) {
          return Left(CacheFailure(e.toString()));
        }
      },
    );
  }
}
