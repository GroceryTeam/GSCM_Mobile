import 'package:gscm_store_owner/Utils/api_client.dart';

class ProductService {
  ProductService();

  Future<dynamic> fetchProducts(int brandId, {index = 1, size = 10}) async {
    final response = await request.get('products', queryParameters: {
      'brand-id': brandId,
      'page-index': index,
      'page-size': size,
    });
    return response.data;
  }
}