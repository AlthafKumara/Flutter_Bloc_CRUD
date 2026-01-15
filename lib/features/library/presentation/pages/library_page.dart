import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/constants/assets_constant.dart';
import '../../../../core/network/network_checker.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_text_style.dart';
import '../../../../routes/app_routes_path.dart';
import '../../../../widgets/button_medium.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/textfield.dart';
import '../../domain/entities/book_entity.dart';
import '../cubit/library/library_cubit.dart';
import '../widgets/book_card_item.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final network = getIt<NetworkInfo>();
  bool isConnected = false;

  @override
  void initState() {
    checkNetwork();
    super.initState();
  }

  Future<void> checkNetwork() async {
    final result = await network.checkIsConnected;

    setState(() {
      isConnected = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral100,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.neutral100,
        title: Text(
          'Library',
          style: AppTextStyle.heading3(
            fontWeight: AppTextStyle.bold,
            color: AppColor.neutral900,
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 16.w),
        actions: [
          CustomButtonMedium.primaryMedium(
            color: AppColor.primary500,
            text: 'Add Book',
            isLoading: false,
            onPressed: () async {
              if (isConnected) {
                final result = await context.pushNamed(
                  AppRoutes.libraryFormBook.name,
                );

                if (result == true) {
                  context.read<LibraryCubit>().getAllBooks();
                }
              } else if (!isConnected) {
                CustomSnackbar.show(
                  context,
                  message: 'No Internet Connection',
                  backgroundColor: AppColor.danger600,
                );
              }
            },
            prefixicon: SizedBox(
              height: 20.w,
              width: 20.w,
              child: Icon(Icons.add, color: AppColor.neutral100),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColor.primary500,
        onRefresh: () => context.read<LibraryCubit>().getAllBooks(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield.textFieldRounded(
                      onChanged: (value) =>
                          context.read<LibraryCubit>().searchBooks(value),
                      enabled: true,
                      isObsecureText: false,
                      keyBoardType: TextInputType.text,
                      hintText: "Search Your Book Here",
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      validator: null,
                      prefixicon: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: Image.asset(Assets.iconSearch),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              BlocBuilder<LibraryCubit, LibraryState>(
                builder: (context, state) {
                  if (state is GetAllBookLoadingState) {
                    return Expanded(child: _buildListLoading(isConnected));
                  } else if (state is GetAllBookSuccessState) {
                    return state.books.isEmpty
                        ? Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: const Center(
                                child: Text('Tidak ada data'),
                              ),
                            ),
                          )
                        : Expanded(child: _buildList(state.books, isConnected));
                  } else if (state is GetAllBookErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Tidak ada data'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<BookEntity> books, bool isConnected) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return BookCardItem(book: books[index], isConnected: isConnected);
      },
      itemCount: books.length,
    );
  }

  Widget _buildListLoading(bool isConnected) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return BookCardItem(isLoading: true, isConnected: isConnected);
      },
      itemCount: 6,
    );
  }
}
