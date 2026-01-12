import '../../../../profile/domain/entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginFlowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginFlowInitialState extends LoginFlowState {}

class LoginFlowSuccessState extends LoginFlowState {
  final ProfileEntity profile;

  LoginFlowSuccessState(this.profile);

  @override
  List<Object?> get props => [profile];
}
