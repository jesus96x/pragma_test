import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  /// Determine if there connection or not
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  /// Constructor
  NetworkInfoImpl(this.connectionChecker);

  /// Instance of [InternetConnectionChecker]
  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
