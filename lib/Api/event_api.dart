import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

class EventService {
  EventService();

  Future<dynamic> fetchEvent({
    required int brandId,
    String? searchTerm,
    int? status,
    int pageIndex = Metadata.pageIndex,
    int pageSize = 99,
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

  Future<bool> updateEventStatus(int brandId, int eventId, int status) async {
    final res = await request.put(
      'events/$eventId/status',
      data: {
        'brandId': brandId,
        'status': status,
      },
    );
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateEvent(int eventId, Map<String, dynamic> data) async {
    final res = await request.put('events/$eventId', data: data);
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> createEvent(int brandId, Map<String, dynamic> event) async {
    final data = {
      'brandId': brandId,
      'eventName': event['eventName'],
      'status': event['status'],
      'details': event['details'],
    };
    final res = await request.post('events', data: data);
    if(res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
