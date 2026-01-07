import 'package:bloc/bloc.dart';

import '../../../../../core/service/image_picker_services.dart';
import '../../../domain/entities/book_entity.dart';
import 'library_form_state.dart';

class LibraryFormCubit extends Cubit<LibraryFormState> {
  final ImagePickerService imagePickerService;

  LibraryFormCubit(this.imagePickerService) : super(const LibraryFormState());

  // ================= IMAGE PICKER =================
  Future<void> pickCover() async {
    final file = await imagePickerService.pickFromGallery();
    if (file != null) {
      emit(state.copyWith(newCoverFile: file, clearOldCover: true));
    }
  }

  // ================= LOAD EDIT DATA =================
    void loadFromBook(BookEntity? book) {
      if (book != null) {
        emit(
          state.copyWith(
            title: book.title,
            author: book.author,
            description: book.description,
            oldCoverUrl: book.coverUrl,   
            newCoverFile: null,
          ),
        );
      }
    }

  // ================= FORM FIELD =================
  void titleChanged(String value) {
    emit(state.copyWith(title: value));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void authorChanged(String value) {
    emit(state.copyWith(author: value));
  }
}
