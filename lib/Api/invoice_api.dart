import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

class InvoiceService {
  InvoiceService();

  Future<dynamic> fetchBill(
      {required DateTime startDate,
      required DateTime endDate,
      required int storeId,
      int pageIndex = Metadata.pageIndex,
      int pageSize = Metadata.pageSize}) async {
    final res = await request.get(
      'bills',
      queryParameters: {
        'page-index': pageIndex,
        'page-size': pageSize,
        'store-id': storeId,
        'start-date': startDate,
        'end-date': endDate,
      },
    );
    return res.data;
  }

  Future<dynamic> fetchReceipt(
      {required DateTime startDate,
      required DateTime endDate,
      required int storeId,
      int pageIndex = Metadata.pageIndex,
      int pageSize = Metadata.pageSize}) async {
    final res = await request.get(
      'receipts',
      queryParameters: {
        'page-index': pageIndex,
        'page-size': pageSize,
        'store-id': storeId,
        'start-date': startDate,
        'end-date': endDate,
      },
    );
    return res.data;
  }
}
