import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/brand_api.dart';
import 'package:gscm_store_owner/Model/brand.dart';
import 'package:gscm_store_owner/Utils/exceptions.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_state.dart';

final brandNotifierProvider =
    StateNotifierProvider.autoDispose<BrandNotifier, BrandState>((ref) {
      final appState = ref.watch(appStartupProvider);
      return appState.maybeWhen(
        authenticated: (user) => BrandNotifier(user.id),
        orElse: () => BrandNotifier(null),
      );
});

class BrandNotifier extends StateNotifier<BrandState> {
  List<Brand> workingBrands = [];
  List<Brand> stoppedBrands = [];
  int? userId;
  BrandService brandDAO = BrandService();

  BrandNotifier(this.userId) : super(const BrandState.initialize()) {
    if(userId != null) {
      fetchBrands(userId!);
    }
  }

  void fetchBrands(int id) async {
    final res = await brandDAO.fetchBrands(id) as List;
    for (var e in res) {
      if (e['status'] as int == 0) {
        workingBrands.add(Brand.fromJson(e));
      } else {
        stoppedBrands.add(Brand.fromJson(e));
      }
    }
    state = BrandState.needSelection(workingBrands, stoppedBrands);
  }

  void setSelectedBrand(Brand selectedBrand) {
    state = BrandState.selected(selectedBrand);
  }

  void selectBrand() {
    state = const BrandState.initialize();
    workingBrands = [];
    stoppedBrands = [];
    fetchBrands(userId!);
  }
}
