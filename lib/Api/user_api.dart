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
    } catch (e) {
      throw WrongUsernamePasswordException();
    }
  }

  Future<dynamic> loginFirebase(String idToken) async {
    final response = await request.post(
      'login/firebase',
      data: {
        'idToken': idToken,
      },
    );
    return response.data;
  }

  Future<bool> deleteFCM(String fcmToken, int userId) async {
    final res = await request.delete(
      'login/token',
      data: {
        'tokenId': fcmToken,
        'userId': userId,
      },
    );
    if (res.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<bool> sendFCM(String fcmToken, int userId) async {
    final res = await request.post(
      'login/token',
      data: {
        'tokenId': fcmToken,
        'userId': userId,
      },
    );
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
