import 'package:app/state/models/product_item_ui.dart';

extension ProductExt on ProductItemUi {
  String get priceDetails => 'Price: $price';

  String get details => '$priceDetails\n'
      '$stock stock(s) available\n'
      '$brand\n'
      'Discounted up to $discountPercentage%\n'
      '$description\n';
}
