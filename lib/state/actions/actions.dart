import 'package:app/api/api_service.dart';
import 'package:app/api/models/data.dart';
import 'package:app/main.dart';
import 'package:app/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

class SaveDataAction extends ReduxAction<AppState> {
  final Data data;

  SaveDataAction({required this.data});

  @override
  AppState reduce() => state.copyWith(data: data);
}

/// Get Data request action
class GetDataAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    final data = await getIt<ApiService>().productsApi.productApi.getData();

    /// TODO: apply pagination as needed
    return state.copyWith(data: data);
  }
}
