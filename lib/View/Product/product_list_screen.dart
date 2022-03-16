import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/product_tile.dart';
import 'package:gscm_store_owner/Accessories/shimmer_block.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/category.dart';
import 'package:gscm_store_owner/View/Product/product_detail_screen.dart';
import 'package:gscm_store_owner/ViewModel/Category/category_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Product/product_notifier.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  Category? chosenCategory;
  List<Category> categoryList = [
    Category(id: -1, name: 'Tất cả'),
  ];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        ref.read(productNotifierProvider.notifier).fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoute.productSearch),
            icon: const Icon(Icons.search),
            splashRadius: 1,
          ),
          IconButton(
            onPressed: () => Get.to(() => const ProductDetailScreen(product: null)),
            icon: const Icon(Icons.add),
            splashRadius: 1,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 12),
              Consumer(
                builder: (context, ref, child) {
                  final categoryState = ref.watch(categoryProvider);
                  return categoryState.maybeWhen(
                    orElse: () => const ShimmerBlock(width: 100, height: 30),
                    data: (categories) {
                      if (categoryList.length != categories.length + 1) {
                        categoryList = [categoryList[0]];
                        categoryList.addAll(categories);
                      }
                      return DropdownButton(
                        value: (chosenCategory != null)
                            ? chosenCategory
                            : categoryList[0],
                        items: categoryList
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                              ),
                            )
                            .toList(),
                        onChanged: (Category? value) {
                          setState(() {
                            chosenCategory = value!;
                            ref
                                .read(productNotifierProvider.notifier)
                                .filterByCategoryId(value.id);
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final productState = ref.watch(productNotifierProvider);
                return productState.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  data: (products, isLoadingMore) => RefreshIndicator(
                    onRefresh: () =>
                        ref.read(productNotifierProvider.notifier).refresh(),
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount:
                          isLoadingMore ? products.length + 1 : products.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 0,
                        thickness: 1.125,
                      ),
                      itemBuilder: (context, index) {
                        if (index == products.length && isLoadingMore) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return ProductTile(product: products[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
