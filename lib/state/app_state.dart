import 'package:app/api/models/data.dart';
import 'package:app/api/models/product.dart';
import 'package:async_redux/async_redux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(Data()) Data data,
    Product? selectedProduct,
    @Default(0) int paginationSkip,
    @Default(Wait.empty) @JsonKey(name: 'wait', ignore: true) Wait wait,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  factory AppState.init() => const AppState(
        data: Data(),
      );
}
