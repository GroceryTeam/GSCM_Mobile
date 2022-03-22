import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/loading_widget.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';

Future<void> showLoadingDialog() {
  hideDialog();
  return Get.defaultDialog<void>(
    title: 'Đang xử lý',
    titleStyle: kInputTitleTextStyle,
    content: const SizedBox(
      height: 200,
      width: 200,
      child: LoadingWidget(),
    )
  );
}

void hideDialog() {
  if(Get.isDialogOpen!) {
    Get.back();
  }
}