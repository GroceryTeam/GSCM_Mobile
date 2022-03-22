import 'package:flutter/material.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/receipt.dart';
import 'package:intl/intl.dart';

class ReceiptDetailScreen extends StatelessWidget {
  final Receipt receipt;

  const ReceiptDetailScreen({Key? key, required this.receipt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    for (var detail in receipt.details) {
      totalPrice += (detail.buyPrice * detail.quantity);
    }
    String total = NumberFormat.currency(locale: 'vi').format(totalPrice);
    return Scaffold(
      appBar: AppBar(
        title: Text('${receipt.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kNeutralColor100,
                  boxShadow: [
                    BoxShadow(
                      color: kNeutralColor.withOpacity(0.2),
                      offset: const Offset(0, 7),
                      blurRadius: 12,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tổng tiền', style: kInputTitleTextStyle),
                    const SizedBox(height: 10),
                    Text(total,
                        style: kListTileMoneyText.copyWith(fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kNeutralColor100,
                  boxShadow: [
                    BoxShadow(
                      color: kNeutralColor.withOpacity(0.2),
                      offset: const Offset(0, 7),
                      blurRadius: 12,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chi tiết', style: kInputTitleTextStyle),
                    const Divider(
                      height: 10,
                      thickness: 1.125,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: receipt.details.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        thickness: 1.125,
                      ),
                      itemBuilder: (context, index) {
                        String productName = receipt.details[index].productName;
                        String quantity =
                            receipt.details[index].quantity.toString();
                        String buyPrice = NumberFormat.currency(locale: 'vi')
                            .format(receipt.details[index].buyPrice);
                        String total = NumberFormat.currency(locale: 'vi')
                            .format((receipt.details[index].quantity *
                                receipt.details[index].buyPrice));
                        return SizedBox(
                          height: 80,
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 8),
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName,
                                        style: kListTilePrimaryText,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Số lượng: $quantity',
                                        style: kListTileSecondaryText,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        total,
                                        style: kListTileMoneyText,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Đơn giá: $buyPrice',
                                        style: kListTileSecondaryText,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
