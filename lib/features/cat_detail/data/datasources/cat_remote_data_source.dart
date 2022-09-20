import 'dart:convert';

import 'package:app_cats/core/error/exception.dart';
import 'package:app_cats/features/cat_detail/data/models/cat_dto.dart';
import 'package:http/http.dart' as http;

/// Contracts
abstract class CatRemoteDataSource {
  /// Calls the https://api.thecatapi.com/v1/breeds endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CatDTO>> getCats();
}

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  /// Constructor
  CatRemoteDataSourceImpl({required this.client});

  /// Instance of [http.Client]
  final http.Client client;

  @override
  Future<List<CatDTO>> getCats() async {
    final response = await client.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'test-api-key'
      },
    );

    if (response.statusCode == 200) {
      List<CatDTO> catsDTO = [];
      for (var item in json.decode(response.body)) {
        catsDTO.add(CatDTO.fromJson(item));
      }
      return catsDTO;
    } else {
      throw ServerException();
    }
  }
}
