// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cats/core/error/exception.dart';

import '/core/network/network_info.dart';
import '/features/cat_detail/data/datasources/cat_local_data_source.dart';
import '/features/cat_detail/data/datasources/cat_remote_data_source.dart';
import '/core/error/failures.dart';
import '/features/cat_detail/domain/entities/cat.dart';
import '/features/cat_detail/domain/repositories/cat_repository.dart';
import 'package:dartz/dartz.dart';

/// Repository implementation of contract [CatRepository]
class CatRepositoryImpl implements CatRepository {
  /// Constructor
  CatRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Instance of [CatRemoteDataSource]
  final CatRemoteDataSource remoteDataSource;

  /// Instance of [CatLocalDataSource]
  final CatLocalDataSource localDataSource;

  /// Instance of [NetworkInfo]
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Cat>>> getCats() async {
    if (await networkInfo.isConnected) {
      try {
        final catsDTO = await remoteDataSource.getCats();
        localDataSource.cacheCats(catsDTO);
        return Right(catsDTO);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCatsDTO = await localDataSource.getCats();
        return Right(localCatsDTO);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
