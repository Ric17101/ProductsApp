import 'package:app/state/models/async_result.dart';
import 'package:app/state/models/product_item_ui.dart';
import 'package:app/ui/product_item.dart';
import 'package:flutter/material.dart';

class ProductsOverview extends StatelessWidget {
  const ProductsOverview({
    required this.productItemUiList,
    required this.loadMoreCallback,
    super.key,
  });

  final AsyncResult<List<ProductItemUi>> productItemUiList;
  final VoidCallback loadMoreCallback;

  @override
  Widget build(BuildContext context) {
    const title = 'Product List';

    final productItems = productItemUiList.when(
      success: (productItems) =>
          productItems
              ?.map((productItem) => ProductItem(title: productItem.title, price: productItem.price))
              .toList() ??
          List.empty(),
      loading: (productItems) => [
        ...productItems
                ?.map((productItem) => ProductItem(title: productItem.title, price: productItem.price))
                .toList() ??
            List.empty(),
        const Center(child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2.0))
      ],
      error: (_) => [Container()],
    );

    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      // TODO: fix ui loading indicator to show previous list
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed: loadMoreCallback,
        child: const Icon(Icons.refresh),
      ),
      body: ListView.builder(
        itemCount: productItems.length,
        itemBuilder: (context, index) => productItems[index],
      ),
    );
  }
}
