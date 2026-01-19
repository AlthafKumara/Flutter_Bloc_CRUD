import 'dart:async';
import 'package:crud_clean_bloc/core/network/network_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final NetworkInfo networkInfo;
  late StreamSubscription _subscription;

  NetworkCubit(this.networkInfo) : super(NetworkInitialState()) {
    _init();
  }

  void _init() async {
    final connected = await networkInfo.checkIsConnected;
    emit(connected ? NetworkConnectedState() : NetworkDisconnectedState());

    _subscription = networkInfo.onStatusChange.listen((connected) {
      networkInfo.setIsConnected = connected;
      emit(connected ? NetworkConnectedState() : NetworkDisconnectedState());
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
