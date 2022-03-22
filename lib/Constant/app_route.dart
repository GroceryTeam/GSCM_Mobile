import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:gscm_store_owner/View/AppStartup/app_startup_page.dart';
import 'package:gscm_store_owner/View/Brand/brand_page.dart';
import 'package:gscm_store_owner/View/Category/category_screen.dart';
import 'package:gscm_store_owner/View/Dashboard/out_of_stock_screen.dart';
import 'package:gscm_store_owner/View/Login/login_screen.dart';
import 'package:gscm_store_owner/View/NotFound/not_found_screen.dart';
import 'package:gscm_store_owner/View/OnBoard/onboard_screen.dart';
import 'package:gscm_store_owner/View/Product/product_list_screen.dart';
import 'package:gscm_store_owner/View/Product/product_search_screen.dart';
import 'package:gscm_store_owner/View/Register/register_screen.dart';
import 'package:gscm_store_owner/View/Store/store_list_screen.dart';

class AppRoute {
  static const String nav = '/';
  static const String login = '/login';
  static const String register = "/register";
  static const String startUp = '/startUp';
  static const String notFound = '/notFound';
  static const String onBoard = '/onBoard';
  static const String appStartup = '/appStartup';
  static const String brandSelect = '/brandSelect';
  static const String productList = '/productList';
  static const String categories = '/categories';
  static const String productSearch = '/productSearch';
  static const String stores = '/stores';
  static const String outOfStock = '/outOfStock';

  static GetPage notFoundScreen = GetPage(name: notFound, page: () => const NotFoundScreen());

  static List<GetPage> getPages = [
    GetPage(name: appStartup, page: () => const AppStartupPage()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: onBoard, page: () => const OnBoardScreen()),
    GetPage(name: brandSelect, page: () => const BrandPage()),
    GetPage(name: productList, page: () => const ProductListScreen()),
    GetPage(name: categories, page: () => const CategoryScreen(),),
    GetPage(name: productSearch, page: () => const ProductSearchScreen()),
    GetPage(name: stores, page: () => const StoreListScreen()),
    GetPage(name: outOfStock, page: () => const OutOfStockScreen()),
  ];
}
