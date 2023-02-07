
import 'package:app/api/products_handler.dart';
import 'package:app/api/sprout_api_client.dart';

class ProductsApi {
  ProductsApi(ApiClient apiClient) {
    _init(apiClient);
  }

  void _init(ApiClient apiClient) {
    _productApi = DataProductsApi(apiClient);
  }

  DataProductsApi get productApi => _productApi;

  late DataProductsApi _productApi;
}