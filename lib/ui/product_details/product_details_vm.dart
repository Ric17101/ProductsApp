import 'package:app/api/models/product.dart';
import 'package:app/state/actions/actions.dart';
import 'package:app/state/app_state.dart';
import 'package:app/state/models/async_result.dart';
import 'package:app/state/models/product_item_ui.dart';
import 'package:app/ui/product_details/product_details_connector.dart';
import 'package:async_redux/async_redux.dart';

class ProductDetailsVmFactory extends VmFactory<AppState, ProductDetailsConnector> {
  @override
  Vm fromStore() => ProductDetailsVm(
        selectedProductItemUi: _selectedProductItemUi,
      );

  AsyncResult<ProductItemUi> get _selectedProductItemUi {
    final product = state.selectedProduct ?? const Product();

    if (isPageLoading(_pageKeys)) return const AsyncResult.loading(ProductItemUi());
    return AsyncResult.success(ProductItemUi(
      id: product.id,
      title: product.title ?? '',
      price: product.price ?? 0,
      thumbnail: product.thumbnail ?? '',
      stock: product.stock ?? 0,
      discountPercentage: product.discountPercentage ?? 0.0,
    ));
  }

  bool isPageLoading(List<String> keys) => _isWaitingForKeys(keys);

  bool _isWaitingForKeys(List<String> keys) => keys.any((k) => state.wait.isWaitingFor(k));

  static const _pageKeys = [GetProductDetailsByIdAction.key];
}

class ProductDetailsVm extends Vm {
  ProductDetailsVm({required this.selectedProductItemUi}) : super(equals: [selectedProductItemUi]);

  final AsyncResult<ProductItemUi> selectedProductItemUi;
}
