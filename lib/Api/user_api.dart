import 'package:gscm_store_owner/Utils/api_client.dart';
import 'dart:convert';

class UserService {
  UserService();

  Future<dynamic> login(String username, String password) async {
    final data = jsonEncode({'username': username, 'password': password});
    try {
      final response = await request.post('login', data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw WrongUsernamePasswordException();
      }
    } 
    catch (e) {
      throw WrongUsernamePasswordException();
    }
  }
}
