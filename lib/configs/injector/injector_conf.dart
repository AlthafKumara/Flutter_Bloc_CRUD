import '../../features/auth/di/auth_dependency.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/cache/hive_local_storage.dart';
import '../../core/cache/local_storage.dart';
import '../../core/network/network_checker.dart';
import '../../features/library/di/library_dependency.dart';
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

  // ================= ROUTER =================
  getIt.registerLazySingleton(() => AppRoutesConf());
}
