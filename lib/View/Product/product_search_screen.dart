import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/loading_widget.dart';
import 'package:gscm_store_owner/Accessories/product_tile.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/View/Product/product_detail_screen.dart';
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
        actions: [
          IconButton(
            onPressed: () async {
              String skuQr = await FlutterBarcodeScanner.scanBarcode(
                '#FF0000',
                'Hủy',
                true,
                ScanMode.QR,
              );
              _textController.text = skuQr;
              ref.read(productSearchNotifier).searchProduct(skuQr);
              /* Product product =
                  await ref.read(productSearchNotifier).searchProdutSku(skuQr);
              Get.to(() => ProductDetailScreen(product: product)); */
            },
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              color: kBlack,
            ),
            splashRadius: 1,
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final model = ref.watch(productSearchNotifier);
          switch (model.status) {
            case ViewStatus.loading:
              return const LoadingWidget();
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
                itemBuilder: (context, index) =>
                    ProductTile(product: model.searchProducts[index]),
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
