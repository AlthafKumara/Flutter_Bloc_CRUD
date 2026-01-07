import '../../../core/service/image_picker_services.dart';
import '../domain/usecases/create_book_usecase.dart';
import '../domain/usecases/delete_books_usecase.dart';
import '../domain/usecases/update_book_usecase.dart';
import '../domain/usecases/upload_book_cover_usecase.dart';
import '../presentation/cubit/library_form/library_form_cubit.dart';

import '../../../configs/injector/injector_conf.dart';
import '../../../core/cache/hive_local_storage.dart';
import '../../../core/cache/local_storage.dart';
import '../../../core/network/network_checker.dart';
import '../data/datasources/book_local_datasource.dart';
import '../data/datasources/book_remote_datasource.dart';
import '../data/repositories/books_repository_impl.dart';
import '../domain/repositories/book_repository.dart';
import '../domain/usecases/get_books_usecase.dart';
import '../presentation/cubit/library/library_cubit.dart';

class LibraryDependency {
  LibraryDependency._();

  static void init() {
    // ================= DATASOURCE =================
    getIt.registerLazySingleton<BookRemoteDatasource>(
      () => BookRemoteDatasourceImpl(),
    );

    getIt.registerLazySingleton<BookLocalDatasource>(
      () => BookLocalDatasourceImpl(localStorage: getIt<LocalStorage>()),
    );

    // ================= REPOSITORY =================
    getIt.registerLazySingleton<BookRepository>(
      () => BooksRepositoryImpl(
        getIt<HiveLocalStorage>(),
        getIt<NetworkInfo>(),
        getIt<BookLocalDatasource>(),
        getIt<BookRemoteDatasource>(),
      ),
    );

    // ================= USECASE =================
    getIt.registerLazySingleton(() => GetBooksUseCase(getIt<BookRepository>()));

    getIt.registerLazySingleton(
      () => CreateBookUsecase(getIt<BookRepository>()),
    );
    getIt.registerLazySingleton(
      () => UploadBookCoverUsecase(getIt<BookRepository>()),
    );
    getIt.registerLazySingleton(
      () => DeleteBooksUsecase(getIt<BookRepository>()),
    );
    getIt.registerLazySingleton(
      () => UpdateBookUsecase(getIt<BookRepository>()),
    );

    // ================================= SERVICE =================================
    getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
    // ================= CUBIT (PALING AKHIR) =================
    getIt.registerFactory(
      () => LibraryCubit(
        getIt<GetBooksUseCase>(),
        getIt<CreateBookUsecase>(),
        getIt<UploadBookCoverUsecase>(),
        getIt<DeleteBooksUsecase>(),
        getIt<UpdateBookUsecase>(),
      ),
    );

    getIt.registerFactory(() => LibraryFormCubit(getIt<ImagePickerService>()));
  }
}
