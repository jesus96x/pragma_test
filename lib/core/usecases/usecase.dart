import '/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  // ** Callable Classes **
  // Parameters have to be put into a container object so that they can be
  // included in this abstract base class method definition.
  Future<Either<Failure, Type>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
