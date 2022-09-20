import 'package:equatable/equatable.dart';

/// Definition abstract of Failures
abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

/// General server failures
class ServerFailure extends Failure {}

/// General cache failures
class CacheFailure extends Failure {}
