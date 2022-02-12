import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gscm_store_owner/Model/user.dart';

part 'app_startup_state.freezed.dart';

@freezed
class AppStartupState with _$AppStartupState {
  const factory AppStartupState.initialize() = _Initialize;
  const factory AppStartupState.unauthenticated() = _Unauthenticated;
  const factory AppStartupState.authenticated(User user) = _Authenticated;
}