import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A ListItem that contains data to display a message.
class ProductItem extends StatelessWidget {
  final String title;
  final String details;
  final String? thumbnail;
  final VoidCallback? onTap;

  const ProductItem({
    required this.title,
    required this.details,
    this.thumbnail,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final networkImage = thumbnail != null
        ? CachedNetworkImage(
            imageUrl: thumbnail!,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : const SizedBox();

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(
        left: 20.0,
        right: 30.0,
      ),
      title: Text(title),
      subtitle: Text(
        details,
        overflow: TextOverflow.visible,
        softWrap: true,
      ),
      leading: networkImage,
    );
  }
}
