import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../configs/injector/injector_conf.dart';
import '../features/library/presentation/cubit/library_cubit.dart';
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
              return LibraryBookDetail();
            },
          ),
        ],
      ),
    ],
  );
}
