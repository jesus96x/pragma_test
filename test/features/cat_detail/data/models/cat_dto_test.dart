import 'dart:convert';

import 'package:app_cats/features/cat_detail/data/models/cat_dto.dart';
import 'package:app_cats/features/cat_detail/data/models/image_dto.dart';
import 'package:app_cats/features/cat_detail/domain/entities/cat.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
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

  test('should be a subclass of Cat entity', () async {
    // Assert
    expect(tCatsDTO.first, isA<Cat>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // Arrange
      final jsonMap = json.decode(fixture('response_cats.json'));
      // Act
      List<CatDTO> result = [];
      for (var element in jsonMap) {
        result.add(CatDTO.fromJson(element));
      }
      // Asset
      expect(result, tCatsDTO);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // Act
      final result = tCatsDTO.first.toJson();
      // Assert
      final expectedJson = {
        'id': '1',
        'name': 'test',
        'description': 'test',
        'image': {'id': 'test', 'url': 'test-url-image'},
        'temperament': 'test',
        'origin': 'test',
        'adaptability': 1,
      };
      expect(result, expectedJson);
    });
  });
}
