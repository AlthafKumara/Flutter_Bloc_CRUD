import '../usecases/create_book_usecase.dart' as create_params;
import '../usecases/delete_books_usecase.dart' as delete_params;
import '../usecases/update_book_usecase.dart' as update_params;
import '../usecases/upload_book_cover_usecase.dart' as upload_book_params;

typedef CreateBookParams = create_params.Params;
typedef UpdateBookParams = update_params.Params;
typedef DeleteBookParams = delete_params.Params;
typedef UploadBookCoverParams = upload_book_params.Params;
