import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Constant/lib_color_schemes.g.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gscm_store_owner/Utils/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotification ps = PushNotification.getInstance();
  await ps.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  // ignore: prefer_const_constructors
  runApp(ProviderScope(child: MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  await Firebase.initializeApp();
  debugPrint('Got a message whilst in the background!');
  debugPrint('Message data: ${event.data}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'GSCM_StoreOwner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightColorScheme,
      ),
      //home: BrandSelection(),
      initialRoute: AppRoute.appStartup,
      unknownRoute: AppRoute.notFoundScreen,
      getPages: AppRoute.getPages,
    );
  }
}
