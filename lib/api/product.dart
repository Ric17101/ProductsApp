import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

part 'product.g.dart';

/// Entity that represents product details from products endpoint
/// TODO: remove unused field indicated on the requirements
@freezed
class Product with _$Product {
  /// Initializes a new instance of the [Product] class
  const factory Product({
    int? id,
    String? title,
    String? description,
    int? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    @Default(<String>[]) List<String> images,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
