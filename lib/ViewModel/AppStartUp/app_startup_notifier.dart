import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/user_api.dart';
import 'package:gscm_store_owner/Model/user.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';
import 'package:gscm_store_owner/Utils/shared_prefs.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_state.dart';

final appStartupProvider = StateNotifierProvider<AppStartupNotifier, AppStartupState>((ref) {
  return AppStartupNotifier();
});

class AppStartupNotifier extends StateNotifier<AppStartupState> {

  UserService userDAO = UserService();

  AppStartupNotifier() : super(const AppStartupState.initialize()) {
    checkAuthentication();
  }

  void checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 3));
    String? token = await getToken();
    if (token == null) {
      state = const AppStartupState.unauthenticated();
    } else {
      myRequest.setBearerToken(token);
      final user = await getUser();
      state = AppStartupState.authenticated(user);
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final res = await userDAO.login(username, password);
      if(res != null) {
        await setToken(res['token'] as String);
        myRequest.setBearerToken(res['token'] as String);
        final User user = User.fromJson(res['information']);
        await setUser(user);
        state = AppStartupState.authenticated(user);
      }
      else {
        throw WrongUsernamePasswordException();
      }
      return true;
    }
    on WrongUsernamePasswordException {
      return false;
    }
  }

  void logout() async {
    await deleteToken();
    state = const AppStartupState.unauthenticated();
  }
}
