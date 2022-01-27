import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:gscm_store_owner/View/Login/login_screen.dart';
import 'package:gscm_store_owner/View/NotFound/not_found_screen.dart';
import 'package:gscm_store_owner/View/Register/register_screen.dart';

class AppRoute {
  static const String nav = '/';
  static const String login = '/login';
  static const String register = "/register";
  static const String startUp = '/startUp';
  static const String notFound = '/notFound';

  static GetPage notFoundScreen = GetPage(name: notFound, page: () => NotFoundScreen());

  static List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
  ];
}
