import 'package:app/api/data.dart';
import 'package:app/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

class SaveDataAction extends ReduxAction<AppState> {
  final Data data;

  SaveDataAction({required this.data});

  @override
  AppState reduce() => state.copyWith(data: data);
}
