import 'dart:convert';

import 'package:app_cats/core/error/exception.dart';
import 'package:app_cats/core/shared/constants/constants_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/features/cat_detail/data/models/cat_dto.dart';

/// Contracts
abstract class CatLocalDataSource {
  /// Gets the cached List<CatDTO> which was gotten the last time
  /// had an internet connection
  ///
  /// Throws [NoLocalDataException] if no cached data is present
  Future<List<CatDTO>> getCats();

  /// Saved in local storage data of cats
  Future<void> cacheCats(List<CatDTO> cats);
}

/// Implementation of contract
class CatLocalDataSourceImpl implements CatLocalDataSource {
  /// Constructor
  CatLocalDataSourceImpl({required this.localStorage});

  /// Instance of [LocalStorageService]
  final LocalStorageService localStorage;

  @override
  Future<List<CatDTO>> getCats() {
    final jsonString = localStorage._instance?.getString(CACHED_CATS);
    List<CatDTO> catsDTO = [];
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      for (var item in jsonMap) {
        catsDTO.add(CatDTO.fromJson(item));
      }
    } else {
      throw CacheException();
    }

    return Future.value(catsDTO);
  }

  @override
  Future<void> cacheCats(List<CatDTO> cats) => localStorage.instance!
      .setString(CACHED_CATS, cats.map((e) => e.toJson()).toList().toString());
}

class LocalStorageService {
  /// Firebase FirebaseInAppMessaging Private Instance
  late SharedPreferences? _instance;

  /// Get FirebaseInAppMessaging Instance
  SharedPreferences? get instance => _instance;

  /// Show if Firebase Dynamic Links has been initialized or not
  bool _hasBeenInitialized = false;

  /// Initialize Firebase Dynamic Links
  Future<void> init() async {
    /// Checks if Firebase Dynamic Links has been initialized or not
    if (_hasBeenInitialized) return;
    _hasBeenInitialized = true;

    /// Create Firebase Dynamic Links instance
    _instance = await SharedPreferences.getInstance();
  }
}
