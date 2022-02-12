import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/View/Brand/brand_page.dart';
import 'package:gscm_store_owner/View/Startup/startup_screen.dart';
import 'package:gscm_store_owner/View/OnBoard/onboard_screen.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_notifier.dart';

class AppStartupPage extends ConsumerWidget {
  const AppStartupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartupProvider);
    return state.when(
      initialize: () => const StartupScreen(),
      unauthenticated: () => const OnBoardScreen(),
      authenticated: (user) => const BrandPage(),
    );
  }
}
