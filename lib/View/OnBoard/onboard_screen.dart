import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gscm_store_owner/Accessories/app_button.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'assets/images/onboard-img.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Chào mừng đến với Grocery',
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Grocery is happy to see you!',
                        style: TextStyle(
                          color: kNeutralColor,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      MainButton(
                        bgColor: kPrimaryColor,
                        height: 60,
                        width: double.infinity,
                        text: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontSize: 21,
                            color: kWhite,
                          ),
                        ),
                        onTap: () => Get.toNamed(AppRoute.login),
                      ),
                      const SizedBox(height: 12),
                      MainButton(
                        bgColor: kWhite ,
                        height: 60,
                        width: double.infinity,
                        hasBorder: true,
                        text: const Text(
                          'Đăng ký',
                          style: TextStyle(
                            fontSize: 21,
                            color: kBlack,
                          ),
                        ),
                        onTap: () => Get.toNamed(AppRoute.register),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
