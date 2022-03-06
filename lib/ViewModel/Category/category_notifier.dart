import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/category_api.dart';
import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Model/category.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<List<Category>>>((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => CategoryNotifier(null),
    selected: (currentBrand) => CategoryNotifier(currentBrand.id),
  );
});

class CategoryNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  int? brandId;
  late int pageIndex = Metadata.pageIndex;
  late int totalPage = 0;
  CategoryService categoryDAO = CategoryService();

  CategoryNotifier(this.brandId) : super(const AsyncValue.loading()) {
    if (brandId != null) {
      fetchCategory();
    }
  }

  void fetchCategory() async {
    final res = await categoryDAO.fetchCategory(brandId!);
    pageIndex = res['pageIndex'] as int;
    totalPage = res['totalPage'] as int;
    List<Category> list = (res['data'] as List)
        .map((category) => Category.fromJson(category))
        .toList();
    state = AsyncValue.data(list);
  }

  void reloadCategory() async {
    state = const AsyncValue.loading();
    final res = await categoryDAO.fetchCategory(brandId!, index: pageIndex);
    pageIndex = res['pageIndex'] as int;
    totalPage = res['totalPage'] as int;
    List<Category> list = (res['data'] as List)
        .map((category) => Category.fromJson(category))
        .toList();
    state = AsyncValue.data(list);
  }

  Future<bool> createCategory(String categoryName) async {
    bool result = await categoryDAO.createCategory(brandId!, categoryName);
    if (result) {
      pageIndex = 1;
      reloadCategory();
      return true;
    }
    return false;
  }

  Future<bool> editCategory(int categoryId, String categoryName) async {
    bool result = await categoryDAO.editCategory(categoryId, categoryName);
    if (result) {
      reloadCategory();
      return true;
    }
    return false;
  }
}
