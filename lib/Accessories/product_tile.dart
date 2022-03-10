import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/View/Product/product_detail_screen.dart';
import 'package:intl/intl.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String productName = product.name;
    String firstLetter = productName[0].toUpperCase();
    String categoryName = product.categoryName;
    String sellPrice =
        NumberFormat.currency(locale: 'vi').format(product.sellPrice);
    String unitLabel = product.unitLabel;
    Color boxColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: kListTilePrimaryText,
                ),
                const SizedBox(height: 8),
                Text(
                  categoryName,
                  style: kListTileSecondaryText,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  sellPrice,
                  style: kListTileMoneyText,
                ),
                const SizedBox(height: 8),
                Text(
                  unitLabel,
                  style: kListTileSecondaryText,
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Get.to(() => ProductDetailScreen(product: product));
      },
    );
  }
}
