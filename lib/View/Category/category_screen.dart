import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/category.dart';
import 'package:gscm_store_owner/ViewModel/Category/category_notifier.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => inputCategory(ref, isEdit: false),
            )
          ],
        ),
        /* floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => inputCategory(ref, isEdit: false),
        ), */
        body: Consumer(
          builder: (context, ref, child) {
            final categoryState = ref.watch(categoryProvider);
            return categoryState.when(
              error: (error, stackTrace) => const Center(
                child: Text('Có lỗi rùi :(('),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              data: (data) => RefreshIndicator(
                onRefresh: () async {
                  ref.read(categoryProvider.notifier).reloadCategory();
                },
                child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(data[index].name),
                    trailing: IconButton(
                      onPressed: () =>
                          inputCategory(ref, category: data[index]),
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: data.length,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void inputCategory(WidgetRef ref,
      {Category? category, bool isEdit = true}) async {
    TextEditingController controller = TextEditingController();
    controller.text = category?.name ?? '';
    await Get.dialog(
      Dialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 5,
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 40, 12, 12),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        late bool result;
                        if (isEdit) {
                          result = await ref
                              .read(categoryProvider.notifier)
                              .editCategory(category!.id, controller.text);
                        } else {
                          result = await ref
                              .read(categoryProvider.notifier)
                              .createCategory(controller.text);
                        }
                        if (result) {
                          Get.back();
                        }
                      },
                      child: Text(isEdit ? 'Lưu' : 'Tạo'),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Container(
                    color: kDangerColor,
                    child: const Icon(
                      Icons.close,
                      color: kWhite,
                    ),
                  ),
                  splashColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
