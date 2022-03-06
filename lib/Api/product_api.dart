import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

class ProductService {
  ProductService();

  Future<dynamic> fetchProducts(
      {required int brandId,
      String? searchTerm,
      int? categoryId,
      index = Metadata.pageIndex,
      size = Metadata.pageSize}) async {
    final response = await request.get(
      'products',
      queryParameters: {
        'brand-id': brandId,
        'search-term': searchTerm,
        'category-id': categoryId,
        'page-index': index,
        'page-size': size,
      },
    );
    return response.data;
  }

  /* Future<dynamic> searchProduct(int brandId, String keyword,
      {index = Metadata.pageIndex, size = Metadata.pageSize}) async {
    final res = await request.get(
      'products',
      queryParameters: {
        'brand-id': brandId,
        'search-term': keyword,
        'page-index': index,
        'page-size': size,
      },
    );
    return res.data;
  }

  Future<dynamic> fetchProductByCategoryId(int brandId, int categoryId,
      {index = Metadata.pageIndex, size = Metadata.pageSize}) async {
    final res = await request.get(
      'products',
      queryParameters: {
        'page-index': index,
        'page-size': size,
        'brand-id': brandId,
        'category-id': categoryId,
      },
    );
    return res.data;
  } */
}
