import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Utils/shared_prefs.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_state.dart';

final appStartupProvider = StateNotifierProvider<AppStartupNotifier, AppStartupState>((ref) {
  return AppStartupNotifier();
});

class AppStartupNotifier extends StateNotifier<AppStartupState> {
  AppStartupNotifier() : super(const AppStartupState.initialize()) {
    checkAuthentication();
  }

  void checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 3));
    String? token = await getToken();
    if (token == null) {
      state = const AppStartupState.unauthenticated();
    } else {
      state = const AppStartupState.authenticated();
    }
  }

  Future<bool> login() async {
    String token = await Future.delayed(const Duration(seconds: 3), () => 'Some token');
    await setToken(token);
    state = const AppStartupState.authenticated();
    return true;
  }

  void logout() async {
    await deleteToken();
    state = const AppStartupState.unauthenticated();
  }
}
