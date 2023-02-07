import 'package:flutter/material.dart';

/// A ListItem that contains data to display a message.
class ProductItem extends StatelessWidget {
  final String title;
  final int price;

  const ProductItem({
    required this.title,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title),
        subtitle: Text('Price: $price'),
      );
}
