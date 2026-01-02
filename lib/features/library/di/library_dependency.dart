import '../../../configs/injector/injector_conf.dart';
import '../../../core/cache/hive_local_storage.dart';
import '../../../core/cache/local_storage.dart';
import '../../../core/network/network_checker.dart';
import '../data/datasources/book_local_datasource.dart';
import '../data/datasources/book_remote_datasource.dart';
import '../data/repositories/books_repository_impl.dart';
import '../domain/repositories/book_repository.dart';
import '../domain/usecases/get_books_usecase.dart';
import '../presentation/cubit/library_cubit.dart';

class LibraryDependency {
  LibraryDependency._();

  static void init() {
    getIt.registerFactory(() => LibraryCubit(getIt<GetBooksUseCase>()));

    getIt.registerLazySingleton(() => GetBooksUseCase(getIt<BookRepository>()));

    getIt.registerLazySingleton<BookRepository>(
      () => BooksRepositoryImpl(
        getIt<HiveLocalStorage>(),
        getIt<NetworkInfo>(),
        getIt<BookLocalDatasource>(),
        getIt<BookRemoteDatasource>(),
      ),
    );

    getIt.registerLazySingleton<BookLocalDatasource>(
      () => BookLocalDatasourceImpl(localStorage: getIt<LocalStorage>()),
    );

    getIt.registerLazySingleton<BookRemoteDatasource>(
      () => BookRemoteDatasourceImpl(),
    );
  }
}
