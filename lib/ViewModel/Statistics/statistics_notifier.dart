import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/product_api.dart';
import 'package:gscm_store_owner/Api/statistics_api.dart';
import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Model/revenue.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';

final statisticsProvider = ChangeNotifierProvider((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => StatisticsNotifier(null),
    selected: (currentBrand) => StatisticsNotifier(currentBrand.id),
  );
});

class StatisticsNotifier extends ChangeNotifier {
  int? brandId;
  List<Product> noosProducts = [];
  List<DailyRevenue> dailyRevenue = [];
  List<MonthlyRevenue> monthlyRevenue = [];
  ProductService productDAO = ProductService();
  StatisticsService statisticsDAO = StatisticsService();
  int pageIndexProduct = Metadata.pageIndex;
  int pageSizeProduct = Metadata.pageSize;
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime startMonth = DateTime.now().subtract(const Duration(days: 365));

  StatisticsNotifier(this.brandId) {
    if (brandId != null) {
      init();
    }
  }

  void init() async {
    await fetchNoosProduct();
    await fetchDailyRevenue();
    await fetchMonthlyRevenue();
    notifyListeners();
  }

  Future<void> fetchNoosProduct() async {
    final res = await productDAO.fetchProducts(brandId: brandId!, status: 2);
    pageIndexProduct = res['pageIndex'];
    pageSizeProduct = res['pageSize'];
    noosProducts = (res['data'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
  }

  void fetchMoreNoosProduct() async {
    if (pageIndexProduct < pageSizeProduct) {
      ++pageIndexProduct;
      await fetchNoosProduct();
      notifyListeners();
    }
  }

  Future<void> fetchDailyRevenue() async {
    final res = await statisticsDAO.fetchRevenue(
      brandId: brandId!,
      startDate: startDate,
      endDate: endDate,
      isDaily: true,
    );
    dailyRevenue = (res['dailyBrandRevenueDetails'] as List)
        .map((revenue) => DailyRevenue.fromJson(revenue))
        .toList();
  }

  Future<void> fetchMonthlyRevenue() async {
    final res = await statisticsDAO.fetchRevenue(
      brandId: brandId!,
      startDate: startMonth,
      endDate: endDate,
      isMonthly: true,
    );
    monthlyRevenue = (res['monthlyBrandRevenueDetails'] as List)
        .map((revenue) => MonthlyRevenue.fromJson(revenue))
        .toList();
  }
}
