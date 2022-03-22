import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/app_button.dart';
import 'package:gscm_store_owner/Accessories/dialog.dart';
import 'package:gscm_store_owner/Accessories/loading_widget.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/store.dart';
import 'package:gscm_store_owner/ViewModel/Store/store_notifier.dart';
import 'package:gscm_store_owner/ViewModel/base_changenotifier.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StoreListScreen extends ConsumerWidget {
  const StoreListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(storeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cửa hàng'),
        actions: [
          IconButton(
            onPressed: () => showStoreDetailModal(context, null, model),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (model.status) {
            case ViewStatus.loading:
              return const LoadingWidget();
            case ViewStatus.error:
              return const Center(
                child: Text('Có lỗi rùi :(('),
              );
            case ViewStatus.complete:
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    if (model.workingStores.isNotEmpty) ...[
                      _buildSectionTitle('Đang hoạt động', kTertiaryColor),
                      ...model.workingStores
                          .map((store) => _buildStoreTile(
                              store, kTertiaryColor, context, model))
                          .toList(),
                      const SizedBox(height: 35),
                    ],
                    if (model.pendingStores.isNotEmpty) ...[
                      _buildSectionTitle('Đang chờ duyệt', kOrange),
                      ...model.pendingStores
                          .map((store) =>
                              _buildStoreTile(store, kOrange, context, model))
                          .toList(),
                      const SizedBox(height: 35),
                    ],
                    if (model.rejectedStores.isNotEmpty) ...[
                      _buildSectionTitle('Bị từ chối', kDangerColor),
                      ...model.rejectedStores
                          .map((store) => _buildStoreTile(
                              store, kDangerColor, context, model))
                          .toList(),
                      const SizedBox(height: 35),
                    ],
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Row(
      children: [
        Text(
          '$title   ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 20,
            width: 20,
            color: color,
          ),
        )
      ],
    );
  }

  Widget _buildStoreTile(
      Store store, Color color, BuildContext context, StoreNotifier model) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          showStoreDetailModal(context, store, model);
        },
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color,
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store.name,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Text(
                store.address,
                style: TextStyle(color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showStoreDetailModal(
      BuildContext context, Store? store, StoreNotifier model) async {
    return await showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        return ReactiveFormBuilder(
          form: () => fb.group({
            'name': FormControl<String>(
              value: store?.name ?? '',
              validators: [Validators.required],
            ),
            'address': FormControl<String>(
              value: store?.address ?? '',
              validators: [Validators.required],
            ),
          }),
          builder: (context, formGroup, child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tên cửa hàng', style: kInputTitleTextStyle),
                  const SizedBox(height: 5),
                  ReactiveTextField(
                    formControlName: 'name',
                    decoration: kTextInputDecoration,
                  ),
                  const SizedBox(height: 16),
                  const Text('Địa chỉ', style: kInputTitleTextStyle),
                  const SizedBox(height: 5),
                  ReactiveTextField(
                    formControlName: 'address',
                    decoration: kTextInputDecoration,
                  ),
                  const SizedBox(height: 18),
                  ReactiveFormConsumer(
                    builder: ((context, formGroup, child) => MainButton(
                          onTap: () async {
                            if (formGroup.valid) {
                              late final bool result;
                              showLoadingDialog();
                              if (store != null) {
                                result = await model.updateStore(
                                  store.id,
                                  formGroup.control('name').value,
                                  formGroup.control('address').value,
                                );
                                hideDialog();
                                Get.back();
                                Fluttertoast.showToast(
                                  msg: (result)
                                      ? 'Cập nhật thành công'
                                      : 'Cập nhật thất bại',
                                );
                              } else {
                                result = await model.createStore(
                                  formGroup.control('name').value,
                                  formGroup.control('address').value,
                                );
                                hideDialog();
                                Get.back();
                                Fluttertoast.showToast(
                                  msg: (result)
                                      ? 'Tạo cửa hàng thành công'
                                      : 'Tạo cửa hàng thất bại',
                                );
                              }
                            }
                          },
                          text: Text(
                            (store != null) ? 'Cập nhật' : 'Tạo',
                            style: TextStyle(
                              color: (formGroup.valid) ? kWhite : kPrimaryColor,
                              fontSize: 16,
                            ),
                          ),
                          bgColor: (formGroup.valid)
                              ? kPrimaryColor
                              : kNeutralColor200,
                          height: 45,
                          width: double.infinity,
                        )),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
