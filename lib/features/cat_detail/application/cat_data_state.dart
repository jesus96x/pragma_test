import '/features/cat_detail/domain/entities/cat.dart';
import '/core/error/failures.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_data_state.freezed.dart';

/// Cat data state
/// - initial
/// - loading
/// - data
/// - error
@freezed
class CatDataState with _$CatDataState {
  const CatDataState._();

  /// Initial: state of CatDataState status empty
  const factory CatDataState.initial() = _Initial;

  /// Loading: state while waiting for information
  const factory CatDataState.loading() = _Loading;

  /// Data: state of notification when the information arrives
  const factory CatDataState.data({required List<Cat> cats}) = _Data;

  /// Error: state when an error
  const factory CatDataState.error(Failure failure) = _Error;
}
