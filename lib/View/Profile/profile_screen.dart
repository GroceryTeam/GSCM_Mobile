import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStartupProvider);
    return appState.maybeWhen(
      orElse: () => const Scaffold(
        body: Center(
          child: Text('Có lỗi rùi :(('),
        ),
      ),
      authenticated: (user) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text('Xin chào ${user.name}'),
              const SizedBox(height: 16),
              section('Danh mục', AppRoute.categories),
              const SizedBox(height: 16),
              section('Nhân viên', ''),
              const SizedBox(height: 16),
              section('Cửa hàng', ''),
              TextButton(
                onPressed: () => ref.read(appStartupProvider.notifier).logout(),
                child: const Text('Đăng xuất',
                    style: TextStyle(color: kDangerColor)),
                style:
                    TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget section(String title, namedPage) {
    return InkWell(
      onTap: () => Get.toNamed(namedPage),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 1.5,
              color: kBlack,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}
