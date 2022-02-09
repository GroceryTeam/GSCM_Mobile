import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_startup_state.freezed.dart';

@freezed
abstract class AppStartupState with _$AppStartupState {
  const factory AppStartupState.initialize() = _Initialize;
  const factory AppStartupState.unauthenticated() = _Unauthenticated;
  const factory AppStartupState.authenticated() = _Authenticated;
}