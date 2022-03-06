import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/event_api.dart';
import 'package:gscm_store_owner/Model/event.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Event/event_state.dart';

final eventNotifierProvider =
    StateNotifierProvider<EventNotifier, EventState>((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => EventNotifier(null),
    selected: (currentBrand) => EventNotifier(currentBrand.id),
  );
});

class EventNotifier extends StateNotifier<EventState> {
  int? brandId;
  List<Event> eventList = [];
  Event? currentEvent;
  int pageIndex = 1;
  int totalPage = 1;
  EventService eventDAO = EventService();

  EventNotifier(this.brandId) : super(const EventState.loading()) {
    if (brandId != null) {
      init();
    }
  }

  void init() async {
    await fetchEvent();
    await fetchActiveEvent();
    debugPrint('${currentEvent?.name}');
    state = EventState.data(currentEvent, eventList);
  }

  Future<void> fetchEvent() async {
    final res = await eventDAO.fetchEvent(brandId: brandId!);
    pageIndex = res['pageIndex'];
    totalPage = res['totalPage'];
    eventList =
        (res['data'] as List).map((event) => Event.fromJson(event)).toList();
  }

  Future<void> fetchActiveEvent() async {
    final res = await eventDAO.fetchEvent(brandId: brandId!, status: 0);
    var eventRes = (res['data'] as List)[0];
    if (eventRes != null) {
      currentEvent = Event.fromJson(eventRes);
    }
  }
}
