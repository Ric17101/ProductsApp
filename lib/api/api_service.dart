import 'package:app/api/products_api.dart';
import 'package:app/api/sprout_api_client.dart';

class ApiService {
  ProductsApi get productsApi => _productsApi ??= ProductsApi(_createApiClient('https://dummyjson.com/products/'));

  ApiClient _createApiClient(String baseUrl) => ApiClient(
        baseUrl: baseUrl,
        onInvalidToken: _onInvalidToken,
      );

  void _onInvalidToken({Error? error}) {
    // TODO: handle error here
  }

  ProductsApi? _productsApi;
}
