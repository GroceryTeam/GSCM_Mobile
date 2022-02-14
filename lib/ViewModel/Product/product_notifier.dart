import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/product_api.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';

final productNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    selected: (currentBrand) => ProductNotifier(currentBrand.id),
    orElse: () => ProductNotifier(null),
  );
});

class ProductNotifier extends ChangeNotifier {
  int? brandId;
  List<Product> products = [];
  ProductService productDAO = ProductService();
  late int totalPage, currentPage;

  ProductNotifier(this.brandId) {
    if (brandId != null) {
      fetchProducts(brandId!);
    }
  }

  void fetchProducts(int id) async {
    final res = await productDAO.fetchProducts(id, /* size: 1 */);
    totalPage = res['totalPage'] as int;
    currentPage = res['pageIndex'] as int;
    for (var product in res['data']) {
      products.add(Product.fromJson(product));
    }
    notifyListeners();
  }

  void fetchMore() async {
    if (currentPage <= totalPage) {
      ++currentPage;
      final res = await productDAO.fetchProducts(brandId!, /* size: 1, */ index: currentPage);
      totalPage = res['totalPage'] as int;
      currentPage = res['pageIndex'] as int;
      for (var product in res['data']) {
        products.add(Product.fromJson(product));
      }
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    final res = await productDAO.fetchProducts(brandId!, /* size: 1 */);
    totalPage = res['totalPage'] as int;
    currentPage = res['pageIndex'] as int;
    List<Product> productList = [];
    for (var product in res['data']) {
      productList.add(Product.fromJson(product));
    }
    products = productList;
    notifyListeners();
  }
}
