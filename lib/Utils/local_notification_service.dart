import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localNoti =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _localNoti.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        if(payload != null) {
          Get.toNamed(payload);
        }
      },
    );
  }

  static void display(RemoteMessage event) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'gscmid',
          'Grocery Store Cloud Management Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
      await _localNoti.show(
        id,
        event.notification!.title,
        event.notification!.body,
        notificationDetails,
        payload: event.data['Screen'],
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
