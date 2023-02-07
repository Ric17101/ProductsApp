import 'package:app/state/app_state.dart';
import 'package:app/ui/products/products_overview_connector.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class ProductApp extends StatelessWidget {
  final store = Store<AppState>(initialState: AppState.init());

  ProductApp({super.key});

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
        store: store,
        child: const MaterialApp(
          home: ProductsOverviewConnector(),
        ),
      );
}
