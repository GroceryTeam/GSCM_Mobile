import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:gscm_store_owner/Utils/local_notification_service.dart';

class PushNotification {
  static PushNotification? _instance;

  static PushNotification getInstance() {
    _instance ??= PushNotification();
    return _instance!;
  }

  static void destroyInstance() {
    _instance = null;
  }

  FirebaseMessaging fcm = FirebaseMessaging.instance;
  bool _initialized = false;
  Map<String, dynamic>? initializedData;

  Future<void> init() async {
    if (!_initialized) {
      NotificationSettings settings = await fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }

      /* FirebaseMessaging.instance.getInitialMessage().then((event) {
        if (event != null) {
          initializedData = {
            'brandId': event.data['brandId'],
            'screen': event.data['screen'],
          };
        }
      }); */

      FirebaseMessaging.onMessage.listen((event) {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('Message data: ${event.data}');

        if (event.notification != null) {
          LocalNotificationService.display(event);
        }
      });

      _initialized = true;
    }
  }

  Future<String?> getFCMToken() async {
    String? fcmToken = await fcm.getToken();
    return fcmToken;
  }
}
