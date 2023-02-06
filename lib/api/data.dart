import 'package:app/api/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';

part 'data.g.dart';

/// Entity that represents overall data from products endpoint
@freezed
class Data with _$Data {
  /// Initializes a new instance of the [Data] class
  const factory Data({
    @Default(<Product>[]) List<Product> products,
    int? total,
    int? skip,
    int? limit,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
