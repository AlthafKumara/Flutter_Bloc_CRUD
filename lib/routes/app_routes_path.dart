enum AppRoutes {
  libraryView(path: "/library_view"),
  libraryBookDetail(path: "/library_book_detail"),
  libraryFormBook(path: "/library_form_book");

  final String path;

  const AppRoutes({required this.path});
}
