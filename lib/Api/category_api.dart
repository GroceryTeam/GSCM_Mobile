import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

class CategoryService {
  CategoryService();

  Future<dynamic> fetchCategory(int brandId,
      {int index = Metadata.pageIndex, int size = Metadata.pageSize}) async {
    final res = await request.get(
      'categories',
      queryParameters: {
        'brand-id': brandId,
        'page-index': index,
        'page-size': size,
      },
    );
    return res.data;
  }

  Future<bool> createCategory(int brandId, String categoryName) async {
    final res = await request.post(
      'categories',
      data: {
        'brandId': brandId,
        'name': categoryName,
      },
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> editCategory(int id, String name) async {
    final res = await request.put(
      'categories/$id',
      data: {
        'name': name,
      },
    );
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
