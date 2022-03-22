import 'package:gscm_store_owner/Utils/api_client.dart';

class StoreService {
  StoreService();

  Future<dynamic> fetchStores(int brandId) async {
    final response = await request.get(
      'stores?',
      queryParameters: {'brand-id': brandId},
    );
    return response.data;
  }

  Future<bool> updateStore(int brandId, int storeId, String name, String address) async {
    final res = await request.put(
      'stores/$storeId',
      data: {
        'brandId': brandId,
        'name': name,
        'address': address,
      },
    );
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> createStore(int brandId, String name, String address) async {
    final res = await request.post(
      'stores',
      data: {
        'brandId': brandId,
        'name': name,
        'address': address,
      },
    );
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
