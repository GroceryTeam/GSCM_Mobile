import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/product_api.dart';
import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import 'package:gscm_store_owner/ViewModel/base_changenotifier.dart';

final productSearchNotifier = ChangeNotifierProvider.autoDispose((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => ProductSearchNotifier(null),
    selected: (currentBrand) => ProductSearchNotifier(currentBrand.id),
  );
});

class ProductSearchNotifier extends BaseChangeNotifier {
  int? brandId;
  String keyword = '';
  List<Product> searchProducts = [];
  ProductService productDAO = ProductService();
  int pageSize = Metadata.pageSize;
  int pageIndex = Metadata.pageIndex;

  ProductSearchNotifier(this.brandId);

  void searchProduct(String keyword) async {
    setStatus(ViewStatus.loading);
    this.keyword = keyword;
    final res = await productDAO.fetchProducts(
      brandId: brandId!,
      searchTerm: keyword,
      index: pageIndex,
      size: pageSize,
    );
    searchProducts = (res['data'] as List).map((product) => Product.fromJson(product)).toList();
    setStatus(ViewStatus.complete);
  }

  void searchMore() {
    if(pageIndex < pageSize) {
      ++pageIndex;
      searchProduct(keyword);
    }
  }
}
