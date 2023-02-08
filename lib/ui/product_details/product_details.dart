import 'package:app/state/models/async_result.dart';
import 'package:app/state/models/product_item_ui.dart';
import 'package:app/ui/product_item.dart';
import 'package:app/extensions/product_ext.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    required this.selectedProductItemUi,
    required this.title,
    super.key,
  });

  final AsyncResult<ProductItemUi> selectedProductItemUi;
  final String title;

  @override
  Widget build(BuildContext context) {
    final productItems = selectedProductItemUi.when(
      success: (productItem) => [
        ProductItem(
          title: '${productItem?.title ?? ' '} (${productItem?.category ?? ' '})',
          details: productItem?.details ?? '',
          thumbnail: productItem?.thumbnail,
        )
      ],
      loading: (_) => [const Center(child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2.0))],
      error: (_) => [Container()],
    );

    return Scaffold(
      appBar: AppBar(title: Text('$title Details')),
      body: ListView.builder(
        itemCount: productItems.length,
        itemBuilder: (context, index) => productItems[index],
      ),
    );
  }
}
