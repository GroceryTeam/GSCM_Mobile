import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/category_api.dart';
import 'package:gscm_store_owner/Api/product_api.dart';
import 'package:gscm_store_owner/Model/category.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Product/product_notifier.dart';
import 'package:gscm_store_owner/ViewModel/base_changenotifier.dart';
import 'package:reactive_forms/reactive_forms.dart';

final productDetailProvider = ChangeNotifierProvider.family
    .autoDispose<ProductDetailNotifier, Product?>((ref, product) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => ProductDetailNotifier(product, null, ref),
    selected: (currentBrand) =>
        ProductDetailNotifier(product, currentBrand.id, ref),
  );
});

class ProductDetailNotifier extends BaseChangeNotifier {
  int? brandId;
  final Product? product;
  List<Category> categories = [];
  List<Product?> unpackedProducts = [null];
  CategoryService categoryDAO = CategoryService();
  ProductService productDAO = ProductService();
  late FormGroup productForm;
  final Ref ref;

  ProductDetailNotifier(this.product, this.brandId, this.ref)
      : super(ViewStatus.loading) {
    productForm = FormGroup({
      'name': FormControl<String>(
        value: product?.name,
        validators: [
          Validators.required,
        ],
      ),
      'sku': FormControl<String>(
        value: product?.sku,
        validators: [
          Validators.required,
        ],
      ),
      'categoryId': FormControl<int>(
        value: product?.categoryId,
        validators: [
          Validators.required,
        ],
      ),
      'unpackedProductId': FormControl<int?>(
        value: product?.unpackedProductId,
      ),
      'unitLabel': FormControl<String>(
        value: product?.unitLabel,
        validators: [
          Validators.required,
        ],
      ),
      'conversionRate': FormControl<int>(
        value: product?.conversionRate,
        validators: [
          Validators.required,
        ],
      ),
      'sellPrice': FormControl<int>(
        value: product?.sellPrice,
        validators: [
          Validators.required,
        ],
      ),
      'status': FormControl<int>(
        value: product?.status,
        validators: [
          Validators.required,
        ],
      ),
      'lowerThreshold': FormControl<int>(
        value: product?.lowerThreshold,
        validators: [
          Validators.min(1),
          Validators.required,
        ],
      ),
    });
    if (brandId != null) {
      init();
    }
  }

  void init() async {
    await fetchUnpackedProduct();
    await fetchCategories();
    setStatus(ViewStatus.complete);
  }

  Future<void> fetchUnpackedProduct() async {
    final res = await productDAO.fetchProducts(brandId: brandId!, size: 999);
    unpackedProducts.addAll((res['data'] as List)
        .map((product) => Product.fromJson(product))
        .toList());
  }

  Future<void> fetchCategories() async {
    final res = await categoryDAO.fetchCategory(brandId!, size: 999);
    categories = (res['data'] as List)
        .map((category) => Category.fromJson(category))
        .toList();
  }

  void updateProduct() async {
    bool result = await productDAO.updateProduct(
      product!.id,
      brandId!,
      productForm.value,
    );
    if (result) {
      ref.read(productNotifierProvider.notifier).refresh();
    }
  }

  void createProduct() async {
    bool result = await productDAO.createProduct(
      brandId!,
      productForm.value,
    );
    if (result) {
      ref.read(productNotifierProvider.notifier).refresh();
    }
  }
}
