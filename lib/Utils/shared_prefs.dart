import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}

Future<bool> settoken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('jwt', token);
}