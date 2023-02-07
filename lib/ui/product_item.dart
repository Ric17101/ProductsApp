import 'package:flutter/material.dart';

/// A ListItem that contains data to display a message.
class ProductItem extends StatelessWidget {
  final String title;
  final int price;
  final VoidCallback? onTap;

  const ProductItem({
    required this.title,
    required this.price,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 8.0,
        ),
        title: Text(title),
        subtitle: Text('Price: $price'),
      );
}
