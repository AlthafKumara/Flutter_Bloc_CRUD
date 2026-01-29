import '../../../configs/injector/injector_conf.dart';
import '../../../core/cache/hive_local_storage.dart';
import '../../../core/cache/local_storage.dart';
import '../../../core/network/network_checker.dart';
import '../data/datasources/profile_local_datasource.dart';
import '../data/datasources/profile_remote_datasource.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/usecases/get_profile_usecase.dart';
import '../presentation/cubit/profile_cubit.dart';

class ProfileDependency {
  static void init() {
    // ================= DATASOURCE =================
    getIt.registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasourceImpl(),
    );

    getIt.registerLazySingleton<ProfileLocalDatasource>(
      () => ProfileLocalDataSourceImpl(getIt<LocalStorage>()),
    );

    // ================= REPOSITORY =================
    getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        getIt<ProfileRemoteDatasource>(),
        getIt<ProfileLocalDatasource>(),
        getIt<HiveLocalStorage>(),
        getIt<NetworkInfo>(),
      ),
    );

    // ================= USECASE =================

    getIt.registerLazySingleton(
      () => GetProfileUsecase(getIt<ProfileRepository>()),
    );

    // ================= CUBIT =================

    getIt.registerFactory(() => ProfileCubit(getIt<GetProfileUsecase>()));
  }
}
