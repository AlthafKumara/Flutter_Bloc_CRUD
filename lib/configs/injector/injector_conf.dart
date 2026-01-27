import 'package:crud_clean_bloc/core/cubit/network_cubit/network_cubit.dart';
import 'package:crud_clean_bloc/core/service/sync_service.dart';
import 'package:crud_clean_bloc/features/library/data/datasources/book_local_datasource.dart';
import 'package:crud_clean_bloc/features/library/data/datasources/book_remote_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/cache/hive_local_storage.dart';
import '../../core/cache/local_storage.dart';
import '../../core/network/network_checker.dart';
import '../../features/auth/di/auth_dependency.dart';
import '../../features/library/di/library_dependency.dart';
import '../../features/profile/di/profile_dependency.dart';
import '../../routes/app_routes_conf.dart';

final getIt = GetIt.instance;

void configureDepedencies() {
  // ================= CORE =================
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfo(
      internetConnectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );

  getIt.registerLazySingleton<LocalStorage>(() => HiveLocalStorage());

  getIt.registerLazySingleton<HiveLocalStorage>(() => HiveLocalStorage());

  // ================= FEATURE =================
  LibraryDependency.init();
  AuthDependency.init();
  ProfileDependency.init();

  // ================= SERVICE =================

  getIt.registerLazySingleton<SyncService>(
    () => SyncServiceImpl(
      bookLocalDatasource: getIt<BookLocalDatasource>(),
      bookRemoteDatasource: getIt<BookRemoteDatasource>(),
    ),
  );
  // ================= CUBIT =================
  getIt.registerLazySingleton(
    () => NetworkCubit(getIt<NetworkInfo>(), getIt<SyncService>()),
  );

  // ================= ROUTER =================
  getIt.registerLazySingleton(() => AppRoutesConf());
}
