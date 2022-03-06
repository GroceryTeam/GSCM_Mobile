import 'package:flutter/material.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

class StoreService {
  StoreService();

  Future<dynamic> fetchStores(int brandId) async {
    final response = await request.get('stores?brand-id=$brandId');
    return response.data;
  }
}