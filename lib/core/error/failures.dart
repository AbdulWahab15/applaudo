import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Failure extends Equatable {}

class SerivceFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NetworkConnectFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NoInternetException implements Exception {}

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
