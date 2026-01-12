import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase _getProfileUsecase;
  ProfileCubit(this._getProfileUsecase) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoadingState());
    final result = await _getProfileUsecase.call(NoParams());
    result.fold(
      (failure) => emit(GetProfileErrorState(failure.message)),
      (profile) => emit(GetProfileSuccessState(profile)),
    );
  }
}
