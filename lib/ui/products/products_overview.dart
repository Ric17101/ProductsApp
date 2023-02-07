import 'package:app/state/models/async_result.dart';
import 'package:app/state/models/product_item_ui.dart';
import 'package:app/ui/product_item.dart';
import 'package:flutter/material.dart';

class ProductsOverview extends StatelessWidget {
  const ProductsOverview({
    required this.productItemUiList,
    super.key,
  });

  final AsyncResult<List<ProductItemUi>> productItemUiList;

  @override
  Widget build(BuildContext context) {
    const title = 'Product List';

    final productItems = productItemUiList.when(
      success: (productItems) =>
          productItems
              ?.map((productItem) => ProductItem(
                    title: productItem.title,
                    price: productItem.price,
                  ))
              .toList() ??
          List.empty(),
      loading: () => [const CircularProgressIndicator(color: Colors.blue, strokeWidth: 2.0)],
      error: (_) => [Container()],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView.builder(
        itemCount: productItems.length,
        itemBuilder: (context, index) => productItems[index],
      ),
    );
  }
}
