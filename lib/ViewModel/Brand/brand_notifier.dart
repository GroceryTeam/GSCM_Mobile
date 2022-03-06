import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/brand_api.dart';
import 'package:gscm_store_owner/Api/store_api.dart';
import 'package:gscm_store_owner/Model/brand.dart';
import 'package:gscm_store_owner/Model/store.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_state.dart';

final brandNotifierProvider =
    StateNotifierProvider<BrandNotifier, BrandState>((ref) {
  final appState = ref.watch(appStartupProvider);
  return appState.maybeWhen(
    authenticated: (user) => BrandNotifier(user.id),
    orElse: () => BrandNotifier(null),
  );
});

final storeProvider = StateProvider<List<Store>>((ref) {
  List<Store> storeList = [];
  final brandState = ref.watch(brandNotifierProvider);
  brandState.maybeWhen(
      orElse: () {},
      selected: (currentBrand) async {
        StoreService storeDAO = StoreService();
        final res = await storeDAO.fetchStores(currentBrand.id) as List;
        storeList.addAll(res.map((e) => Store.fromJson(e)).toList());
      });
  return storeList;
});

class BrandNotifier extends StateNotifier<BrandState> {
  int? userId;
  BrandService brandDAO = BrandService();

  BrandNotifier(this.userId) : super(const BrandState.initialize()) {
    if (userId != null) {
      fetchBrands(userId!);
    }
  }

  void fetchBrands(int id) async {
    final res = await brandDAO.fetchBrands(id) as List;
    List<Brand> workingBrands = [];
    for (var e in res) {
      if (e['status'] as int == 0) {
        workingBrands.add(Brand.fromJson(e));
      }
    }
    state = BrandState.needSelection(workingBrands);
  }

  void setSelectedBrand(Brand selectedBrand) {
    state = BrandState.selected(selectedBrand);
  }

  void selectBrand() {
    state = const BrandState.initialize();
    fetchBrands(userId!);
  }
}
