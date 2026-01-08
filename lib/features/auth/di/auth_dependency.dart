import '../../../configs/injector/injector_conf.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/cubit/auth/auth_cubit.dart';
import '../presentation/cubit/auth_login_form/auth_login_form_cubit.dart';

class AuthDependency {
  AuthDependency._();

  static void init() {
    // ================= DATASOURCE =================

    getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(),
    );

    // ================= REPOSITORY =================
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteDatasource>()),
    );

    // ================= USECASE =================

    getIt.registerLazySingleton(() => LoginUsecase(getIt<AuthRepository>()));

    // ================= CUBIT =================

    getIt.registerFactory(() => AuthCubit(getIt<LoginUsecase>()));

    getIt.registerFactory(() => AuthLoginFormCubit());
  }
}
