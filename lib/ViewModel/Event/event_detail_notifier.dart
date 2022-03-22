import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/event_api.dart';
import 'package:gscm_store_owner/Api/product_api.dart';
import 'package:gscm_store_owner/Model/event.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Event/event_notifier.dart';
import 'package:gscm_store_owner/ViewModel/base_changenotifier.dart';

final eventDetailProvider = ChangeNotifierProvider.autoDispose
    .family<EventDetailNotifier, Event>((ref, event) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => EventDetailNotifier(null, event, ref),
    selected: (currentBrand) =>
        EventDetailNotifier(currentBrand.id, event, ref),
  );
});

class EventDetailNotifier extends BaseChangeNotifier {
  List<Product> products = [];
  int? brandId;
  ProductService productDAO = ProductService();
  Event event;
  final Ref ref;
  EventService eventDAO = EventService();

  EventDetailNotifier(this.brandId, this.event, this.ref)
      : super(ViewStatus.loading) {
    if (brandId != null) {
      init();
    }
  }

  void init() async {
    await fetchProduct();
    debugPrint('product list is empty: ${products.isEmpty}');
    setStatus(ViewStatus.complete);
  }

  Future<void> fetchProduct() async {
    final res = await productDAO.fetchProducts(brandId: brandId!, size: 999);
    products = (res['data'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
  }

  void changeNewPrice(Map<String, dynamic> data) {
    event.details
        .firstWhere((detail) => detail.productId == (data['productId'] as int))
        .newPrice = (data['newPrice'] as int);
    notifyListeners();
  }

  bool addNewProduct(Map<String, dynamic> data) {
    Product selectedProduct = data['product'] as Product;
    int newPrice = data['newPrice'] as int;
    for(var detail in event.details) {
      if(detail.productId == selectedProduct.id) {
        return false;
      }
    }
    EventDetail newDetail = EventDetail(
      eventId: event.id,
      productId: selectedProduct.id,
      productName: selectedProduct.name,
      newPrice: newPrice,
      originalPrice: selectedProduct.sellPrice,
      sku: selectedProduct.sku,
    );
    event.details.add(newDetail);
    notifyListeners();
    return true;
  }

  Future<bool> updateEvent() async {
    bool result = await eventDAO.updateEvent(event.id, event.toJson());
    if (result) {
      ref.read(eventNotifierProvider.notifier).reload();
    }
    return result;
  }

  Future<bool> createEvent() async {
    bool result = await eventDAO.createEvent(brandId!, event.toJson());
    if (result) {
      ref.read(eventNotifierProvider.notifier).reload();
    }
    return result;
  }
}
