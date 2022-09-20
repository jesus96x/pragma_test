import 'dart:convert';

import 'package:app_cats/features/cat_detail/data/models/cat_DTO.dart';
import 'package:app_cats/features/cat_detail/data/models/image_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tImageDTO = ImageDTO(id: 'test', url: 'test-url-image');

  group('fromJson', () {
    test('should return a valid model', () async {
      // Arrange
      final jsonMap = json.decode(fixture('response_cats.json'));
      // Act
      List<CatDTO> result = [];
      for (var element in jsonMap) {
        // Asset
        expect(CatDTO.fromJson(element).image.url, tImageDTO.url);
      }
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // Act
      final result = tImageDTO.toJson();
      // Assert
      final expectedJson = {
        'id': 'test',
        'url': 'test-url-image',
      };
      expect(result, expectedJson);
    });
  });
}
