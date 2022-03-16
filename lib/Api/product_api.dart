import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

class ProductService {
  ProductService();

  Future<dynamic> fetchProducts(
      {required int brandId,
      String? searchTerm,
      int? categoryId,
      index = Metadata.pageIndex,
      size = Metadata.pageSize,
      int? status,
      String? sku}) async {
    final response = await request.get(
      'products',
      queryParameters: {
        'brand-id': brandId,
        'search-term': searchTerm,
        'category-id': categoryId,
        'status': status,
        'sku': sku,
        'page-index': index,
        'page-size': size,
      },
    );
    return response.data;
  }

  Future<bool> updateProduct(
      int productId, int brandId, Map<String, dynamic> data) async {
    final res = await request.put(
      'products/$productId',
      queryParameters: {
        'brand-id': brandId,
      },
      data: data,
    );
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> createProduct(int brandId, Map<String, dynamic> data) async {
    final res = await request.post(
      'products',
      queryParameters: {
        'brand-id': brandId,
      },
      data: data,
    );
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
