import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/cache/hive_local_storage.dart';
import '../../core/cache/local_storage.dart';
import '../../core/network/network_checker.dart';
import '../../features/library/di/library_dependency.dart';
import '../../routes/app_routes_conf.dart';

final getIt = GetIt.I;
void configureDepedencies() {
  LibraryDependency.init();

  getIt.registerLazySingleton(() => AppRoutesConf());

  getIt.registerLazySingleton<LocalStorage>(() => HiveLocalStorage());
  getIt.registerLazySingleton(() => HiveLocalStorage());
  getIt.registerLazySingleton(
    () => NetworkInfo(
      internetConnectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
}
