import 'package:app/state/actions/actions.dart';
import 'package:app/state/app_state.dart';
import 'package:app/state/models/product_item_ui.dart';
import 'package:app/ui/product_details/product_details.dart';
import 'package:app/ui/product_details/product_details_vm.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class ProductDetailsConnector extends StatelessWidget {
  const ProductDetailsConnector(this.productItem, {super.key});

  final ProductItemUi productItem;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, ProductDetailsVm>(
        vm: () => ProductDetailsVmFactory(),
        onInitialBuild: (_, store, __) => store.dispatch(GetProductDetailsByIdAction(productItem.id ?? 0)),
        builder: (context, vm) => ProductDetails(
          title: productItem.title,
          selectedProductItemUi: vm.selectedProductItemUi,
        ),
      );
}
