import 'package:crud_clean_bloc/configs/injector/injector_conf.dart';
import 'package:crud_clean_bloc/features/library/data/models/get_books_model.dart';
import 'package:crud_clean_bloc/features/library/presentation/cubit/library_cubit.dart';
import 'package:crud_clean_bloc/features/library/presentation/pages/library_book_detail.dart';
import 'package:crud_clean_bloc/features/library/presentation/pages/library_view.dart';
import 'package:crud_clean_bloc/routes/app_routes_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
            builder: (context, state) {
              return LibraryBookDetail(book: state.extra as GetBooksModel);
            },
          ),
        ],
      ),
    ],
  );
}
