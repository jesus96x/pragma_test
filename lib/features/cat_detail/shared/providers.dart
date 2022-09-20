import '/core/network/network_info.dart';
import '/features/cat_detail/data/datasources/cat_local_data_source.dart';
import '/features/cat_detail/data/datasources/cat_remote_data_source.dart';
import '/features/cat_detail/data/repositories/cat_repository_impl.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import '/features/cat_detail/application/cat_data_notifier.dart';
import '/features/cat_detail/application/cat_data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/cat_detail/domain/usecases/get_cats.dart';

/// Provider of Rate commerce - Tags state notifier
final catsNotifierProvider =
    StateNotifierProvider<CatDataNotifier, CatDataState>(
  (ref) => CatDataNotifier(
    caseUse: ref.watch(caseUseGetCatsProvider),
  ),
);

// ignore: slash_for_doc_comments
/**
 **Dependency Injection*
 */

final internetConnectionCheckerProvider =
    Provider((ref) => InternetConnectionChecker());

final networkInfoProvider = Provider(
    (ref) => NetworkInfoImpl(ref.watch(internetConnectionCheckerProvider)));

final httpClientProvider = Provider((ref) => http.Client());

final catRemoteDataSourceProvider = Provider(
    (ref) => CatRemoteDataSourceImpl(client: ref.watch(httpClientProvider)));

final localStorageServiceProvider = Provider((ref) => LocalStorageService());

final catLocalSourceProvider = Provider((ref) => CatLocalDataSourceImpl(
    localStorage: ref.watch(localStorageServiceProvider)));

final catRepositoryProvider = Provider((ref) => CatRepositoryImpl(
    remoteDataSource: ref.watch(catRemoteDataSourceProvider),
    localDataSource: ref.watch(catLocalSourceProvider),
    networkInfo: ref.watch(networkInfoProvider)));

final caseUseGetCatsProvider =
    Provider((ref) => GetCats(ref.watch(catRepositoryProvider)));
