import 'package:gscm_store_owner/Utils/api_client.dart';

class StatisticsService {
  StatisticsService();

  Future<dynamic> fetchRevenue({
    required int brandId,
    required DateTime startDate,
    required DateTime endDate,
    bool isDaily = false,
    bool isMonthly = false,
    int? storeId,
  }) async {
    final res = await request.get(
      'statistic',
      queryParameters: {
        'brand-id': brandId,
        'start-date': startDate,
        'end-date': endDate,
        'return-date-result': isDaily,
        'return-month-result': isMonthly,
        'store-id': storeId,
      },
    );
    return res.data;
  }
}
