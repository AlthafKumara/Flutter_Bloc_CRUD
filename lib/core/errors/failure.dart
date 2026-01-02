import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;
  const Failure(this.message);
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = "Server error"]) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = "Cache error"]) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = "Network error"]) : super(message);
}
