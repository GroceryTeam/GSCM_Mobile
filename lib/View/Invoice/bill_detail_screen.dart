import 'package:flutter/material.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/bill.dart';
import 'package:intl/intl.dart';

class BillDetailScreen extends StatelessWidget {
  final Bill bill;

  const BillDetailScreen({Key? key, required this.bill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    for (var detail in bill.details) {
      totalPrice += (detail.sellPrice * detail.quantity);
    }
    String total = NumberFormat.currency(locale: 'vi').format(totalPrice);
    return Scaffold(
      appBar: AppBar(
        title: Text('${bill.id}'),
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
                      itemCount: bill.details.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        thickness: 1.125,
                      ),
                      itemBuilder: (context, index) {
                        String productName = bill.details[index].productName;
                        String quantity =
                            bill.details[index].quantity.toString();
                        String sellPrice = NumberFormat.currency(locale: 'vi')
                            .format(bill.details[index].sellPrice);
                        String total = NumberFormat.currency(locale: 'vi')
                            .format((bill.details[index].quantity *
                                bill.details[index].sellPrice));
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
                                        'Đơn giá: $sellPrice',
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
