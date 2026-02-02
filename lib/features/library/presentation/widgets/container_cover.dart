import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud_clean_bloc/features/library/data/models/local/local_book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_color.dart';
import '../cubit/library_form/library_form_state.dart';

class ContainerCover extends StatelessWidget {
  final LibraryFormState? state;
  final LocalBookModel? book;

  const ContainerCover({super.key, this.state, this.book});

  @override
  Widget build(BuildContext context) {
    final File? newFile = state?.newCoverFile;
    final String? localPath = book?.coverPath;
    final String? coverUrl = book?.coverUrl;

    // 1️⃣ JIKA ADA URL → pakai CachedNetworkImage
    if (coverUrl != null &&
        coverUrl.isNotEmpty &&
        localPath == null &&
        newFile == null) {
      return _networkCover(coverUrl);
    }

    // 2️⃣ SELAIN ITU → pakai container biasa (file / placeholder)
    return _localCover(file: newFile, localPath: localPath);
  }

  Widget _localCover({File? file, String? localPath}) {
    DecorationImage? image;

    if (file != null) {
      image = DecorationImage(fit: BoxFit.cover, image: FileImage(file));
    } else if (localPath != null && localPath.isNotEmpty) {
      image = DecorationImage(
        fit: BoxFit.cover,
        image: FileImage(File(localPath)),
      );
    }

    return Container(
      width: 180.w,
      height: 280.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColor.neutral400.withValues(alpha: 0.5),
        image: image,
      ),
      child: image == null ? Icon(Icons.add, size: 20.sp) : null,
    );
  }

  Widget _networkCover(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: 180.w,
        height: 280.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
        ),
      ),
      placeholder: (_, _) => _placeholder(),
      errorWidget: (_, _, _) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 180.w,
      height: 280.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColor.neutral400.withValues(alpha: 0.5),
      ),
    );
  }
}
