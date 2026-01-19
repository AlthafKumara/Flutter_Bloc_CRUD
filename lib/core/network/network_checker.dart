import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../errors/failure.dart';

typedef EitherNetwork<T> = Future<Either<Failure, T>> Function();

class NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfo({required this.internetConnectionChecker});

  bool _isConnected = true;

  Future<bool> get checkIsConnected => internetConnectionChecker.hasConnection;

  Stream<bool> get onStatusChange => internetConnectionChecker.onStatusChange
      .map((status) => status == InternetConnectionStatus.connected);

  Future<Either<Failure, T>> check<T>({
    required EitherNetwork<T> connected,
    required EitherNetwork<T> notConnected,
  }) async {
    final isConnected = await checkIsConnected;
    _isConnected = isConnected;

    if (isConnected) {
      return connected.call();
    } else {
      return notConnected.call();
    }
  }

  set setIsConnected(bool value) {
    _isConnected = value;
  }

  bool get isConnected => _isConnected;
}
