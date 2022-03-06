import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gscm_store_owner/Api/user_api.dart';
import 'package:gscm_store_owner/Model/user.dart' as model;
import 'package:gscm_store_owner/Utils/api_client.dart';
import 'package:gscm_store_owner/Utils/push_notification_service.dart';
import 'package:gscm_store_owner/Utils/shared_prefs.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_state.dart';

final appStartupProvider =
    StateNotifierProvider<AppStartupNotifier, AppStartupState>((ref) {
  return AppStartupNotifier();
});

class AppStartupNotifier extends StateNotifier<AppStartupState> {
  UserService userDAO = UserService();
  FirebaseAuth auth = FirebaseAuth.instance;

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
      final model.User user = await getUser();
      String? fcmToken = await PushNotification.getInstance().getFCMToken();
      if (fcmToken != null) {
        bool result = await userDAO.sendFCM(fcmToken, user.id);
        if (result) {
          debugPrint('send FCM success check login');
        }
      }
      state = AppStartupState.authenticated(user);
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final res = await userDAO.login(username, password);
      if (res != null) {
        await setToken(res['token'] as String);
        myRequest.setBearerToken(res['token'] as String);
        final model.User user = model.User.fromJson(res['information']);
        await setUser(user);
        String? fcmToken = await PushNotification.getInstance().getFCMToken();
        if (fcmToken != null) {
          bool result = await userDAO.sendFCM(fcmToken, user.id);
          if (result) {
            debugPrint('send FCM success login uid/pwd');
          }
        }
        state = AppStartupState.authenticated(user);
      } else {
        throw WrongUsernamePasswordException();
      }
      return true;
    } on WrongUsernamePasswordException {
      return false;
    }
  }

  void logout() async {
    await deleteToken();
    if (auth.currentUser != null) {
      auth.signOut();
    }
    model.User user = await getUser();
    await deleteUser();
    String? fcmToken = await PushNotification.getInstance().getFCMToken();
    if (fcmToken != null) {
      bool result = await userDAO.deleteFCM(fcmToken, user.id);
      if (result) {
        debugPrint('send FCM success logout');
      }
    }
    state = const AppStartupState.unauthenticated();
  }

  Future<void> loginFirebase() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await auth.signInWithCredential(credential);
    String idToken = await userCredential.user!.getIdToken();
    final res = await userDAO.loginFirebase(idToken);
    await setToken(res['token'] as String);
    myRequest.setBearerToken(res['token'] as String);
    final model.User user = model.User.fromJson(res['information']);
    await setUser(user);
    String? fcmToken = await PushNotification.getInstance().getFCMToken();
    if (fcmToken != null) {
      bool result = await userDAO.sendFCM(fcmToken, user.id);
      if (result) {
        debugPrint('send FCM success login firebase');
      }
    }
    state = AppStartupState.authenticated(user);
  }
}
