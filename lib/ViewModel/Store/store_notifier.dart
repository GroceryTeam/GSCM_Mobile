import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/store_api.dart';
import 'package:gscm_store_owner/Model/store.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import 'package:gscm_store_owner/ViewModel/base_changenotifier.dart';

final storeNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => StoreNotifier(null),
    selected: (currentBrand) => StoreNotifier(currentBrand.id),
  );
});

class StoreNotifier extends BaseChangeNotifier {
  int? brandId;
  List<Store> storeList = [];
  List<Store> workingStores = [];
  List<Store> pendingStores = [];
  List<Store> rejectedStores = [];
  StoreService storeDAO = StoreService();

  StoreNotifier(this.brandId) : super(ViewStatus.loading) {
    if (brandId != null) {
      init();
    }
  }

  void init() async {
    await fetchStores();
    setStatus(ViewStatus.complete);
  }

  Future<void> fetchStores() async {
    final res = await storeDAO.fetchStores(brandId!) as List;
    storeList = res.map((store) => Store.fromJson(store)).toList();
    workingStores = storeList.where((store) => store.status == 0).toList();
    pendingStores = storeList.where((store) => store.status == 1).toList();
    rejectedStores = storeList.where((store) => store.status == 2).toList();
  }

  Future<bool> updateStore(int storeId, String name, String address) async {
    bool result = await storeDAO.updateStore(brandId!, storeId, name, address);
    if(result) {
      init();
    }
    return result;
  }

  Future<bool> createStore(String name, String address) async {
    bool result = await storeDAO.createStore(brandId!, name, address);
    if(result) {
      init();
    }
    return result;
  }
}
