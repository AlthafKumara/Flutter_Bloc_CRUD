part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

// ========================= GET PROFILE ===============================
class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {
  final ProfileEntity profile;

  const GetProfileSuccessState(this.profile);

  @override
  List<Object> get props => [profile];
}

class GetProfileErrorState extends ProfileState {
  final String message;

  const GetProfileErrorState(this.message);

  @override
  List<Object> get props => [message];
}
