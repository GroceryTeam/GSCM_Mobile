import 'package:shared_preferences/shared_preferences.dart';
import 'package:gscm_store_owner/Model/user.dart';

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}

Future<bool> setToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('jwt', token);
}

Future<void> deleteToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('jwt');
}

Future<bool> setUser(User user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', user.id);
  await prefs.setString('userName', user.name);
  await prefs.setString('userEmail', user.email);
  await prefs.setString('userPhone', user.phone);
  await prefs.setString('userUsername', user.username);
  return true;
}

Future<User> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int id = prefs.getInt('userId')!;
  String name = prefs.getString('userName')!;
  String email = prefs.getString('userEmail')!;
  String phone = prefs.getString('userPhone')!;
  String username = prefs.getString('userUsername')!;
  return User(id: id, name: name, email: email, phone: phone, username: username);
}

Future<void> deleteUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userId');
  prefs.remove('userName');
  prefs.remove('userEmail');
  prefs.remove('userPhone');
  prefs.remove('userUsername');
}

Future<bool> setFCMToken(String fcmToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString('fcm', fcmToken);
}