import '/core/usecases/usecase.dart';
import '/core/error/failures.dart';
import '/features/cat_detail/domain/entities/cat.dart';
import '/features/cat_detail/domain/repositories/cat_repository.dart';

import 'package:dartz/dartz.dart';

/// Use case for obtain all cats
class GetCats extends UseCase<List<Cat>, NoParams> {
  /// Constructor
  GetCats(this.repository);

  /// Instance of repository
  final CatRepository repository;

  @override
  Future<Either<Failure, List<Cat>>> call(NoParams params) async =>
      await repository.getCats();
}
