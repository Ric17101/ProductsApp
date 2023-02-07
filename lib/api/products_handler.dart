import 'package:app/api/models/data.dart';
import 'package:app/api/models/product.dart';
import 'package:app/api/sprout_api_client.dart';

class DataProductsApi {
  final ApiClient apiClient;

  DataProductsApi(this.apiClient);

  /// Get all Products
  /// HTTP Code 200: List of Product
  /// https://dummyjson.com/products?limit=10&skip={PAGINATION_SKIP}&select=title,price,thumbnail,stock,discountPercentage
  Future<Data> getData() async {
    final queryParams = <String, dynamic>{};
    queryParams['limit'] = '10';
    queryParams['skip'] = '0';
    queryParams['select'] = 'title,price,thumbnail,stock,discountPercentage';

    final baseUri = Uri.parse(apiClient.baseUrl);
    final uri = baseUri.replace(queryParameters: queryParams, path: '/${baseUri.path}');

    return await apiClient.dio.getUri(uri).then((response) => Data.fromJson(response.data));
  }

  /// Get the product details by id
  /// HTTP Code 200: Product details
  /// https://dummyjson.com/products/{PRODUCT_ID}
  Future<Product> getById(int id) async {
    final queryParams = <String, dynamic>{};

    final baseUri = Uri.parse(apiClient.baseUrl);
    final uri = baseUri.replace(queryParameters: queryParams, path: '/${baseUri.path}$id/');

    return await apiClient.dio.getUri(uri).then((response) => Product.fromJson(response.data));
  }
}
