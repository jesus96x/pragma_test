import '/core/error/failures.dart';
import '/features/cat_detail/domain/entities/cat.dart';

import 'package:dartz/dartz.dart';

/// Repository contract ~ get list of cats
abstract class CatRepository {
  /// Obtain all data of cats
  Future<Either<Failure, List<Cat>>> getCats();
}
