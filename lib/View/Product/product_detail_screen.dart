import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/app_button.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Product/product_detail_notifier.dart';
import 'package:gscm_store_owner/ViewModel/base_changenotifier.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product? product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product?.name ?? 'Tạo sản phẩm'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final model = ref.watch(productDetailProvider(widget.product));
          switch (model.status) {
            case ViewStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ViewStatus.complete:
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: ReactiveForm(
                    formGroup: model.productForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text('Tên sản phẩm'),
                        ReactiveTextField<String>(
                          formControlName: 'name',
                        ),
                        const SizedBox(height: 16),
                        const Text('Mã sản phẩm'),
                        ReactiveTextField<String>(
                          formControlName: 'sku',
                        ),
                        const SizedBox(height: 16),
                        const Text('Danh mục'),
                        ReactiveDropdownField(
                          formControlName: 'categoryId',
                          items: model.categories
                              .map(
                                (category) => DropdownMenuItem(
                                  child: Text(category.name),
                                  value: category.id,
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text('Giá bán'),
                        ReactiveTextField<int>(
                          formControlName: 'sellPrice',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        const Text('Sản phẩm đơn vị'),
                        ReactiveDropdownField(
                          formControlName: 'unpackedProductId',
                          items: model.unpackedProducts.map((product) {
                            if (product == null) {
                              return const DropdownMenuItem(
                                child: Text('Không'),
                                value: null,
                              );
                            } else {
                              return DropdownMenuItem(
                                child: Text(product.name),
                                value: product.id,
                              );
                            }
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text('Tỉ lệ quy đổi'),
                        ReactiveTextField<int>(
                          formControlName: 'conversionRate',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        const Text('Đơn vị'),
                        ReactiveTextField<String>(
                          formControlName: 'unitLabel',
                        ),
                        const SizedBox(height: 16),
                        const Text('Ngưỡng hết hàng'),
                        ReactiveTextField<int>(
                          formControlName: 'lowerThreshold',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        const Text('Trạng thái'),
                        ReactiveRadioListTile<int>(
                          formControlName: 'status',
                          value: 0,
                          title: const Text('Đang bán'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        ReactiveRadioListTile<int>(
                          formControlName: 'status',
                          value: 1,
                          title: const Text('Ngừng bán'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        ReactiveRadioListTile<int>(
                          formControlName: 'status',
                          value: 2,
                          title: const Text('Sắp hết hàng'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        const SizedBox(height: 20),
                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) => Center(
                            child: MainButton(
                              height: 40,
                              width: 80,
                              bgColor: (formGroup.valid)
                                  ? kPrimaryColor
                                  : kNeutralColor200,
                              text: Text(
                                (widget.product != null) ? 'Cập nhật' : 'Tạo mới',
                                style: TextStyle(
                                  color: (formGroup.valid)
                                      ? kWhite
                                      : kPrimaryColor,
                                ),
                              ),
                              onTap: () {
                                if (formGroup.valid) {
                                  if(widget.product != null) {
                                    model.updateProduct();
                                  }
                                  else {
                                    model.createProduct();
                                  }
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            case ViewStatus.error:
              return const Center(
                child: Text('Có lỗi rùi :(('),
              );
          }
        },
      ),
    );
  }
}
