import 'package:app_cats/core/error/exception.dart';
import 'package:app_cats/features/cat_detail/data/datasources/cat_remote_data_source.dart';
import 'package:app_cats/features/cat_detail/data/models/cat_dto.dart';
import 'package:app_cats/features/cat_detail/data/models/image_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'cat_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CatRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = CatRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('response_cats.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getCats', () {
    final tCatsDTO = [
      CatDTO(
        id: '1',
        name: 'test',
        description: 'test',
        image: const ImageDTO(id: 'test', url: 'test-url-image'),
        temperament: 'test',
        origin: 'test',
        adaptability: 1,
      ),
      CatDTO(
        id: '2',
        name: 'test',
        description: 'test',
        image: const ImageDTO(id: 'test', url: 'test-url-image'),
        temperament: 'test',
        origin: 'test',
        adaptability: 1,
      )
    ];
    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json',
        () {
      // Arrange
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture('response_cats.json'), 200));
      // Act
      dataSource.getCats();
      // Assert
      verify(mockClient.get(
        Uri.parse('https://api.thecatapi.com/v1/breeds'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'test-api-key'
        },
      ));
    });

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getCats();
        // assert
        expect(result, equals(tCatsDTO));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // Arrange
        setUpMockHttpClientFailure404();
        // Act
        final call = dataSource.getCats;
        // Assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
