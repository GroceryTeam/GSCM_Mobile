import 'package:flutter/material.dart';
import 'package:gscm_store_owner/Model/product.dart';

class ProductDetailScreen extends StatelessWidget {

  final Product product;

  const ProductDetailScreen({ Key? key, required this.product }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status = (product.status == 0) ? 'Đang bán' : 'Hết hàng';
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${product.id}'),
            Text('Tên sản phẩm: ${product.name}'),
            Text('Danh mục: ${product.categoryName}'),
            Text('Sản phẩm con: ${product.unpackedProductName}'),
            Text('Số lượng quy đổi: ${product.conversionRate}'),
            Text('Giá bán: ${product.sellPrice}'),
            Text('Đơn vị: ${product.unitLabel}'),
            Text('Ngưỡng hết hàng: ${product.lowerThreshold}'),
            Text('Trang thái: $status'),
          ],
        ),
      ),
    );
  }
}