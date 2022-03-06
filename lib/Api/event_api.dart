import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

class EventService {
  EventService();

  Future<dynamic> fetchEvent({
    required int brandId,
    String? searchTerm,
    int? status,
    int pageIndex = Metadata.pageIndex,
    int pageSize = Metadata.pageSize,
  }) async {
    final res = await request.get(
      'events',
      queryParameters: {
        'brand-id': brandId,
        'search-term': searchTerm,
        'status': status,
        'page-index': pageIndex,
        'page-size': pageSize,
      },
    );
    return res.data;
  }
}
