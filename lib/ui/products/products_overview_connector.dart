import 'package:app/state/actions/actions.dart';
import 'package:app/state/app_state.dart';
import 'package:app/ui/products/products_overview.dart';
import 'package:app/ui/products/products_overview_vm.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class ProductsOverviewConnector extends StatelessWidget {
  const ProductsOverviewConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, ProductsOverviewVm>(
        vm: () => ProductsOverviewVmFactory(),
        // TODO: can be used when no need to access state
        // E.g. run the dispatch action
        // converter: (store) => ProductsOverviewVm(
        //   loadMoreCallback: () {},
        //   productItemUiList: const AsyncResult.success([]),
        // ),
        onInitialBuild: (_, store, __) => store.dispatch(GetDataAction()),
        builder: (context, vm) => ProductsOverview(
          productItemUiList: vm.productItemUiList,
          loadMoreCallback: vm.loadMoreCallback,
        ),
      );
}
