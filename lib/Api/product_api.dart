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
}
