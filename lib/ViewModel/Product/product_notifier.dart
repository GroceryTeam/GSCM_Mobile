import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/product_api.dart';
import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Product/product_state.dart';

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    selected: (currentBrand) => ProductNotifier(currentBrand.id),
    orElse: () => ProductNotifier(null),
  );
});

class ProductNotifier extends StateNotifier<ProductState> {
  int? brandId;
  late List<Product> products;
  ProductService productDAO = ProductService();
  late int totalPage, pageIndex = Metadata.pageIndex;
  String? searchTerm;
  int? categoryId;

  ProductNotifier(this.brandId) : super(const ProductState.loading()) {
    if (brandId != null) {
      fetchProducts();
    }
  }

  void fetchProducts() async {
    final res = await productDAO.fetchProducts(
      brandId: brandId!,
      searchTerm: searchTerm,
      categoryId: categoryId,
    );
    totalPage = res['totalPage'] as int;
    pageIndex = res['pageIndex'] as int;
    products = (res['data'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
    state = ProductState.data(products, false);
  }

  void fetchMore() async {
    if (pageIndex <= totalPage) {
      state = ProductState.data(products, true);
      ++pageIndex;
      final res = await productDAO.fetchProducts(
        brandId: brandId!,
        searchTerm: searchTerm,
        categoryId: categoryId,
        index: pageIndex,
      );
      totalPage = res['totalPage'] as int;
      pageIndex = res['pageIndex'] as int;
      products.addAll((res['data'] as List)
          .map((product) => Product.fromJson(product))
          .toList());
      state = ProductState.data(products, false);
    }
  }

  Future<void> refresh() async {
    state = const ProductState.loading();
    searchTerm = null;
    categoryId = null;
    fetchProducts();
  }

  void searchProduct(String searchTerm) async {
    state = const ProductState.loading();
    this.searchTerm = searchTerm;
    categoryId = null;
    final res = await productDAO.fetchProducts(
      brandId: brandId!,
      searchTerm: searchTerm,
      categoryId: categoryId,
    );
    totalPage = res['totalPage'] as int;
    pageIndex = res['pageIndex'] as int;
    products = (res['data'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
    state = ProductState.data(products, false);
  }

  void filterByCategoryId(int categoryId) async {
    state = const ProductState.loading();
    this.categoryId = categoryId;
    searchTerm = null;
    final res = await productDAO.fetchProducts(
      brandId: brandId!,
      searchTerm: searchTerm,
      categoryId: categoryId,
    );
    totalPage = res['totalPage'] as int;
    pageIndex = res['pageIndex'] as int;
    products = (res['data'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
    state = ProductState.data(products, false);
  }
}
