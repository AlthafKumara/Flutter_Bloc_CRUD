import 'package:crud_clean_bloc/core/cache/hive_local_storage.dart';
import 'package:crud_clean_bloc/core/cache/local_storage.dart';
import 'package:crud_clean_bloc/core/network/network_checker.dart';
import 'package:crud_clean_bloc/features/library/di/library_dependency.dart';
import 'package:crud_clean_bloc/routes/app_routes_conf.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.I;
void configureDepedencies() {
  LibraryDependency.init();

  getIt.registerLazySingleton(() => AppRoutesConf());

  getIt.registerLazySingleton<LocalStorage>(() => HiveLocalStorage());

  getIt.registerLazySingleton(
    () => NetworkInfo(
      internetConnectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
}
