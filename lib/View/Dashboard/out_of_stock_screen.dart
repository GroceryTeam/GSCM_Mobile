import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Accessories/product_tile.dart';
import 'package:gscm_store_owner/ViewModel/Statistics/statistics_notifier.dart';

class OutOfStockScreen extends ConsumerWidget {
  const OutOfStockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noosProducts = ref.watch(
      statisticsProvider.select((value) => value.noosProducts),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hàng sắp hết'),
      ),
      body: ListView.separated(
        itemCount: noosProducts.length,
        separatorBuilder: (context, index) => const Divider(
          height: 0,
          thickness: 1.125,
        ),
        itemBuilder: (context, index) =>
            ProductTile(product: noosProducts[index]),
      ),
    );
  }
}
