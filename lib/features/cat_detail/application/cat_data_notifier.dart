import 'package:app_cats/core/usecases/usecase.dart';

import '/features/cat_detail/application/cat_data_state.dart';
import '/features/cat_detail/domain/usecases/get_cats.dart';
import '/features/cat_detail/domain/entities/cat.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Class where handler states that may be while obtain data about cat of
/// repository
class CatDataNotifier extends StateNotifier<CatDataState> {
  /// Constructor
  CatDataNotifier({required this.caseUse})
      : super(const CatDataState.initial());

  /// Instance of case use
  final GetCats caseUse;

  /// get list of [Cat]
  /// or
  /// Throws Exception
  Future<void> getCats() async {
    state = const CatDataState.loading();

    final result = await caseUse(NoParams());
    state = result.fold((failure) => CatDataState.error(failure),
        (cats) => CatDataState.data(cats: cats));
  }
}
