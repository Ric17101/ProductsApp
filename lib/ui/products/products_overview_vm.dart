import 'package:app/state/app_state.dart';
import 'package:app/ui/products/products_overview_connector.dart';
import 'package:async_redux/async_redux.dart';

class ProductsOverviewVmFactory extends VmFactory<AppState, ProductsOverviewConnector> {
  @override
  Vm fromStore() => ProductsOverviewVm(
        size: 0,
      );
}

class ProductsOverviewVm extends Vm {
  ProductsOverviewVm({
    required this.size,
  }) : super(equals: [size]);

  final int size;
}
