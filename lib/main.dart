import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';
import 'package:gscm_store_owner/Utils/api_client.dart';

import 'View/Login/login_screen.dart';
import 'View/NotFound/not_found_screen.dart';
import 'View/Register/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // ignore: prefer_const_constructors
  runApp(ProviderScope(child: MyApp()));
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
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoute.startUp,
      unknownRoute: AppRoute.notFoundScreen,
      getPages: AppRoute.getPages,
    );
  }
}