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

    return state.copyWith(data: data);
  }
}

/// Get more products paginated request action
class LoadMoreDataAction extends LoadingAction {
  LoadMoreDataAction() : super(actionKey: key);

  static const key = 'load-more-data-action';

  @override
  Future<AppState> reduce() async {
    final data = await getIt<ApiService>().productsApi.productApi.getData(paginationSkip: (state.data.skip ?? 0) + 10);
    final updatedData = data.copyWith(products: [...state.data.products, ...data.products]);

    return state.copyWith(data: updatedData);
  }
}

/// Get product details by id request action
class GetProductDetailsByIdAction extends LoadingAction {
  GetProductDetailsByIdAction(this.id) : super(actionKey: key);

  final int id;

  static const key = 'get-product-details-by-id-action';

  @override
  Future<AppState> reduce() async {
    final product = await getIt<ApiService>().productsApi.productApi.getById(id);

    return state.copyWith(selectedProduct: product);
  }
}