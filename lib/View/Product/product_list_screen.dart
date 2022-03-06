import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/shimmer_block.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/View/Product/product_detail_screen.dart';
import 'package:gscm_store_owner/ViewModel/Category/category_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Product/product_notifier.dart';
import 'package:intl/intl.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
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
      drawer: Drawer(
        child: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final categoryState = ref.watch(categoryProvider);
              return categoryState.maybeWhen(
                orElse: () => Column(
                  children: const [
                    ShimmerBlock(width: 70, height: 40),
                    SizedBox(height: 10),
                    ShimmerBlock(width: 70, height: 40),
                    SizedBox(height: 10),
                    ShimmerBlock(width: 70, height: 40),
                    SizedBox(height: 10),
                    ShimmerBlock(width: 70, height: 40),
                  ],
                ),
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => ListTile(
                      title: Text(data[index].name),
                      onTap: () {
                        _textController.clear();
                        ref
                            .read(productNotifierProvider.notifier)
                            .filterByCategoryId(data[index].id);
                        Get.back();
                        //FocusScope.of(context).unfocus();
                      }),
                ),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
          title: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                fillColor: kWhite,
                filled: true,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                ref
                    .read(productNotifierProvider.notifier)
                    .searchProduct(_textController.text);
                //FocusScope.of(context).unfocus();
              }
            },
          )
        ],
      )),
      body: Consumer(
        builder: (context, ref, child) {
          final productState = ref.watch(productNotifierProvider);
          return productState.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            data: (products, isLoadingMore) => RefreshIndicator(
              onRefresh: () =>
                  ref.read(productNotifierProvider.notifier).refresh(),
              child: Column(
                children: [
                  Expanded(
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
                        String productName = products[index].name;
                        String firstLetter = productName[0].toUpperCase();
                        String categoryName = products[index].categoryName;
                        String sellPrice = NumberFormat.currency(locale: 'vi')
                            .format(products[index].sellPrice);
                        String unitLabel = products[index].unitLabel;
                        Color boxColor = Colors.primaries[
                            Random().nextInt(Colors.primaries.length)];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          title: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: boxColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    firstLetter,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: boxColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      categoryName,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: kNeutralColor,
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      sellPrice,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor,
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      unitLabel,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: kNeutralColor,
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.to(
                              () =>
                                  ProductDetailScreen(product: products[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
