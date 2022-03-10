import 'dart:math';

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
        appBar: AppBar(
          title: const Text('Thông tin'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildProfile(),
              const SizedBox(height: 10),
              const Divider(thickness: 0),
              _section(
                icon: Icon(
                  Icons.branding_watermark,
                  color: kGrey,
                ),
                title: Text(
                  'Chọn thương hiệu',
                  style: TextStyle(color: kGrey),
                ),
                onTap: () {},
              ),
              _section(
                icon: Icon(
                  Icons.store,
                  color: kGrey,
                ),
                title: Text(
                  'Cửa hàng',
                  style: TextStyle(color: kGrey),
                ),
                onTap: () {},
              ),
              _section(
                icon: Icon(
                  Icons.person,
                  color: kGrey,
                ),
                title: Text(
                  'Nhân viên',
                  style: TextStyle(color: kGrey),
                ),
                onTap: () {},
              ),
              _section(
                icon: Icon(
                  Icons.category,
                  color: kGrey,
                ),
                title: Text(
                  'Danh mục',
                  style: TextStyle(color: kGrey),
                ),
                onTap: () {},
              ),
              _section(
                icon: Icon(
                  Icons.logout,
                  color: kGrey,
                ),
                title: Text(
                  'Đăng xuất',
                  style: TextStyle(color: kDangerColor),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(
      {required Icon icon, required Text title, required VoidCallback onTap}) {
    return Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: 20),
                  title,
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          const Divider(thickness: 0),
        ],
    );
  }

  Widget _buildProfile() {
    return Consumer(
      builder: (context, ref, child) {
        final appState = ref.watch(appStartupProvider);
        return appState.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          authenticated: (user) {
            String name = user.name.toUpperCase();
            String firstLetter = name[0];
            String username = user.username;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Get.theme.colorScheme.onPrimaryContainer
                        .withOpacity(0.2),
                    child: Text(
                      firstLetter,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: kListTileMoneyText.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        username,
                        style: kListTilePrimaryText.copyWith(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
