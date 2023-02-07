import 'package:app/api/api_service.dart';
import 'package:app/main.dart';
import 'package:app/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

/// Reusable loading page state for request action
abstract class LoadingAction extends ReduxAction<AppState> {
  LoadingAction({required this.actionKey});

  final String actionKey;

  @override
  Future<void> before() async => await dispatchAsync(WaitAction.add(actionKey));

  @override
  void after() => dispatch(WaitAction.remove(actionKey));
}

/// Get Data request action
class GetDataAction extends LoadingAction {
  GetDataAction() : super(actionKey: key);

  static const key = 'get-data-action';

  @override
  Future<AppState> reduce() async {
    final data = await getIt<ApiService>().productsApi.productApi.getData();

    /// TODO: apply pagination as needed
    return state.copyWith(data: data);
  }
}

/// Get more products paginated request action
class LoadMoreDataAction extends LoadingAction {
  LoadMoreDataAction() : super(actionKey: key);

  static const key = 'load-more-data-action';

  @override
  Future<AppState> reduce() async {
    final data = await getIt<ApiService>().productsApi.productApi.getData(paginationSkip: state.paginationSkip + 10);

    // (data.skip ?? 0) + 1
    final updatedData = data.copyWith(products: [...state.data.products, ...data.products]);
    return state.copyWith(data: updatedData);
  }
}
