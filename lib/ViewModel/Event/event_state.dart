import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gscm_store_owner/Model/event.dart';

part 'event_state.freezed.dart';

@freezed
class EventState with _$EventState {
  const factory EventState.loading() = _Loading;
  const factory EventState.data(Event? currentEvent, List<Event> eventList) = _Data;
}