import 'package:bloc/bloc.dart';
import 'login_flow_state.dart';
import '../../../../profile/domain/entities/profile_entity.dart';

class LoginFlowCubit extends Cubit<LoginFlowState> {
  LoginFlowCubit() : super(LoginFlowInitialState());

  bool loginSuccess = false;
  ProfileEntity? profile;

  void loginComplete() {
    loginSuccess = true;
    check();
  }

  void profileComplete(ProfileEntity data) {
    profile = data;
    check();
  }

  void check() {
    if (loginSuccess && profile != null) {
      emit(LoginFlowSuccessState(profile!));
    }
  }
}
