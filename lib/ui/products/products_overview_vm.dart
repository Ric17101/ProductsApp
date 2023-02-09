import 'dart:ui';

import 'package:app/state/actions/actions.dart';
import 'package:app/state/app_state.dart';
import 'package:app/state/models/async_result.dart';
import 'package:app/state/models/product_item_ui.dart';
import 'package:app/ui/products/products_overview_connector.dart';
import 'package:async_redux/async_redux.dart';

class ProductsOverviewVmFactory extends VmFactory<AppState, ProductsOverviewConnector> {
  @override
  Vm fromStore() => ProductsOverviewVm(
        productItemUiList: _productItemUiList,
        loadMoreCallback: _loadMoreCallback,
      );

  AsyncResult<List<ProductItemUi>> get _productItemUiList {
    final productList = state.data.products
        .map((product) => ProductItemUi(
              id: product.id,
              title: product.title ?? '',
              price: product.price ?? 0,
              thumbnail: product.thumbnail ?? '',
              stock: product.stock ?? 0,
              discountPercentage: product.discountPercentage ?? 0.0,
            ))
        .toList();

    if (isPageLoading(_pageKeys)) return AsyncResult.loading(productList);

    return AsyncResult.success(productList);
  }

  void _loadMoreCallback() => dispatch(LoadMoreDataAction());

  bool isPageLoading(List<String> keys) => _isWaitingForKeys(keys);

  bool _isWaitingForKeys(List<String> keys) => keys.any((k) => state.wait.isWaitingFor(k));

  static const _pageKeys = [
    GetDataAction.key,
    LoadMoreDataAction.key,
  ];
}

class ProductsOverviewVm extends Vm {
  ProductsOverviewVm({
    required this.productItemUiList,
    required this.loadMoreCallback,
  }) : super(equals: [productItemUiList]);

  final AsyncResult<List<ProductItemUi>> productItemUiList;
  final VoidCallback loadMoreCallback;
}
