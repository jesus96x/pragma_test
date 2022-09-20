import 'package:app_cats/core/error/exception.dart';
import 'package:app_cats/core/error/failures.dart';
import 'package:app_cats/core/network/network_info.dart';
import 'package:app_cats/features/cat_detail/data/datasources/cat_local_data_source.dart';
import 'package:app_cats/features/cat_detail/data/datasources/cat_remote_data_source.dart';
import 'package:app_cats/features/cat_detail/data/models/cat_dto.dart';
import 'package:app_cats/features/cat_detail/data/models/image_dto.dart';
import 'package:app_cats/features/cat_detail/data/repositories/cat_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'cat_repository_impl_test.mocks.dart';

@GenerateMocks([CatRemoteDataSource, CatLocalDataSource, NetworkInfo])
void main() {
  late CatRepositoryImpl repository;
  late MockCatLocalDataSource mockLocalDataSource;
  late MockCatRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockCatRemoteDataSource();
    mockLocalDataSource = MockCatLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CatRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getCats', () {
    const tName1 = 'Abyssinian';
    const tName2 = 'Arabian Mau';
    final tCatsDTO = [
      CatDTO(
        id: 'id',
        name: tName1,
        description: 'test',
        image: const ImageDTO(id: 'test', url: 'test-url-image'),
        temperament: 'test',
        origin: 'test',
        adaptability: 1,
      ),
      CatDTO(
        id: 'id',
        name: tName2,
        description: 'test',
        image: const ImageDTO(id: 'test', url: 'test-url-image'),
        temperament: 'test',
        origin: 'test',
        adaptability: 1,
      ),
    ];

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCats()).thenAnswer((_) async => tCatsDTO);
        // Act
        final result = await repository.getCats();
        // Assert
        verify(mockRemoteDataSource.getCats());
        expect(result, equals(Right(tCatsDTO)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCats()).thenAnswer((_) async => tCatsDTO);
        // Act
        await repository.getCats();
        // Assert
        verify(mockRemoteDataSource.getCats());
        verify(mockLocalDataSource.cacheCats(tCatsDTO));
      });

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(mockRemoteDataSource.getCats()).thenThrow(ServerException());
          // Act
          final result = await repository.getCats();
          // Assert
          verify(mockRemoteDataSource.getCats());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // Arrange
        when(mockLocalDataSource.getCats()).thenAnswer((_) async => tCatsDTO);
        // Act
        final result = await repository.getCats();
        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCats());
        expect(result, equals(Right(tCatsDTO)));
      });

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getCats()).thenThrow(CacheException());
          // act
          final result = await repository.getCats();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCats());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
