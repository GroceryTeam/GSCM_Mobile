import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';
import 'package:gscm_store_owner/View/Product/product_detail_screen.dart';
import 'package:gscm_store_owner/ViewModel/Product/product_notifier.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(productNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: model.fetchMore, icon: const Icon(Icons.add)),
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoute.notFound);
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
              onRefresh: model.refresh,
              child: ListView.separated(
                itemCount: model.products.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  thickness: 1,
                ),
                itemBuilder: (context, index) => ListTile(
                  title: Text('Tên sản phẩm: ${model.products[index].name}\n' +
                      'Giá mua: ${model.products[index].buyPrice}\n' +
                      'Giá bán: ${model.products[index].sellPrice}\n' +
                      'Danh mục: ${model.products[index].categoryName}'),
                  onTap: () {
                    Get.to(ProductDetailScreen(product: model.products[index]));
                  },
                ),
              ),
        
        ),
      ),
    );
  }
}
