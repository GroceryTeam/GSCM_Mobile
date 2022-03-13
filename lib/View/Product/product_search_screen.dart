import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/product_tile.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/ViewModel/Product/product_search_notifier.dart';
import 'package:gscm_store_owner/ViewModel/base_changenotifier.dart';

class ProductSearchScreen extends ConsumerStatefulWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductSearchScreenState();
}

class _ProductSearchScreenState extends ConsumerState<ProductSearchScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        leading: const BackButton(color: Colors.black),
        title: TextField(
          controller: _textController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Nhập tên sản phẩm',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _textController.clear,
            ),
          ),
          onSubmitted: (value) =>
              ref.read(productSearchNotifier).searchProduct(value),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final model = ref.watch(productSearchNotifier);
          switch (model.status) {
            case ViewStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ViewStatus.complete:
              if (model.searchProducts.isEmpty) {
                return const SizedBox.shrink();
              }
              return ListView.separated(
                itemCount: model.searchProducts.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                  thickness: 1.125,
                ),
                itemBuilder: (context, index) => ProductTile(
                  product: model.searchProducts[index],
                ),
              );
            default:
              return const Center(
                child: Text('Có lỗi rùi :(('),
              );
          }
        },
      ),
    );
  }
}
