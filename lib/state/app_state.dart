import 'package:app/api/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isUserLoggedIn,
    @Default(Data()) Data data,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  factory AppState.init() => const AppState(
        isUserLoggedIn: false,
        data: Data(),
      );
}
