import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_item_ui.freezed.dart';

@freezed
class ProductItemUi with _$ProductItemUi {
  const factory ProductItemUi({
    int? id,
    @Default('') String title,
    @Default(0) int price,
    @Default('') String thumbnail,
    @Default(0) int stock,
    @Default(0.0) double discountPercentage,
    @Default('') String category,
    @Default('') String brand,
    @Default('') String description,
  }) = _ProductItemUi;

  const ProductItemUi._();

  factory ProductItemUi.init() => const ProductItemUi();
}
