import 'dart:io';

import 'package:equatable/equatable.dart';

class LibraryFormState extends Equatable {
  final String title;
  final String author;
  final String description;
  final String? oldCoverUrl;
  final File? newCoverFile;

  final bool isEdit;

  const LibraryFormState({
    this.title = '',
    this.author = '',
    this.description = '',
    this.newCoverFile,
    this.oldCoverUrl,
    this.isEdit = false,
  });

  LibraryFormState copyWith({
    String? title,
    String? author,
    String? description,
    String? oldCoverUrl,
    File? newCoverFile,

    bool clearOldCover = false,
  }) {
    return LibraryFormState(
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      oldCoverUrl: clearOldCover ? null : oldCoverUrl ?? this.oldCoverUrl,
      newCoverFile: newCoverFile ?? this.newCoverFile,
    );
  }

  @override
  List<Object?> get props => [
    title,
    author,
    description,
    oldCoverUrl,
    newCoverFile,
    isEdit, 
  ];
}
