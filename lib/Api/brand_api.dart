import 'package:gscm_store_owner/Utils/api_client.dart';

class BrandService {
  BrandService();

  Future<dynamic> fetchBrands(int userId) async {
    final response = await request.get('brands?user-id=$userId');
    return response.data;
  }
}