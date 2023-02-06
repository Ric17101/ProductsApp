import 'package:app/ui/list_item.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/heading_item.dart';
import 'package:app/ui/message_item.dart';

class ProductApp extends StatelessWidget {
  ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Product List';

    final items = List<ListItem>.generate(
      1000,
      (i) => i % 6 == 0 ? HeadingItem('Heading $i') : MessageItem('Sender $i', 'Message body $i'),
    );

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
      ),
    );
  }
}
