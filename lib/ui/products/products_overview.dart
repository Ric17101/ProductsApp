import 'package:app/state/models/async_result.dart';
import 'package:app/state/models/product_item_ui.dart';
import 'package:app/ui/product_details/product_details_connector.dart';
import 'package:app/ui/product_item.dart';
import 'package:flutter/material.dart';

class ProductsOverview extends StatefulWidget {
  const ProductsOverview({
    required this.productItemUiList,
    required this.loadMoreCallback,
    super.key,
  });

  final AsyncResult<List<ProductItemUi>> productItemUiList;
  final VoidCallback loadMoreCallback;

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  final ScrollController _scrollController = ScrollController();

  bool get loading => widget.productItemUiList.maybeWhen(loading: (_) => true, orElse: () => false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !loading) {
        widget.loadMoreCallback();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Product List';

    final items = widget.productItemUiList.maybeWhen(
      success: (productItems) =>
          productItems
              ?.map((productItem) => ProductItem(
                    title: productItem.title,
                    details: '${productItem.price}',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => ProductDetailsConnector(productItem)),
                      );
                    },
                  ))
              .toList() ??
          List.empty(),
      loading: (productItems) =>
          productItems
              ?.map((productItem) => ProductItem(title: productItem.title, details: '${productItem.price}'))
              .toList() ??
          List.empty(),
      orElse: () => List.empty(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: LayoutBuilder(
        builder: (context, constraint) => Stack(
          children: [
            ListView.separated(
              controller: _scrollController,
              itemCount: items.length,
              itemBuilder: (context, index) => items[index],
              separatorBuilder: (_, index) => const Divider(height: 1.0),
            ),
            if (loading) ...[
              Positioned(
                left: 0,
                bottom: 0,
                child: SizedBox(
                  width: constraint.maxWidth,
                  height: 80.0,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
