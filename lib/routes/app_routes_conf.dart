import '../features/library/domain/entities/book_entity.dart';
import '../features/library/presentation/cubit/library_form/library_form_cubit.dart';
import '../features/library/presentation/pages/library_form_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../configs/injector/injector_conf.dart';
import '../features/library/presentation/cubit/library/library_cubit.dart';
import '../features/library/presentation/pages/library_book_detail.dart';
import '../features/library/presentation/pages/library_view.dart';
import 'app_routes_path.dart';

class AppRoutesConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoutes.libraryView.path,
    routes: [
      GoRoute(
        path: AppRoutes.libraryView.path,
        name: AppRoutes.libraryView.name,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LibraryCubit>()..getAllBooks(),
          child: const LibraryView(),
        ),
        routes: [
          GoRoute(
            path: AppRoutes.libraryBookDetail.path,
            name: AppRoutes.libraryBookDetail.name,
            builder: (context, state) {
              final book = state.extra as BookEntity;
              return BlocProvider.value(
                value: getIt<LibraryCubit>(),
                child: LibraryBookDetail(book: book),
              );
            },
          ),
          GoRoute(
            path: AppRoutes.libraryFormBook.path,
            name: AppRoutes.libraryFormBook.name,
            builder: (context, state) {
              final book = state.extra as BookEntity?;

              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        getIt<LibraryFormCubit>()..loadFromBook(book),
                  ),
                  BlocProvider.value(value: getIt<LibraryCubit>()),
                ],

                child: LibraryFormBook(), 
              );
            },
          ),
        ],
      ),
    ],
  );
}
