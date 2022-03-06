import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/ViewModel/Invoice/invoice_notifier.dart';
import 'package:intl/intl.dart';

class ReceiptTab extends ConsumerStatefulWidget {
  const ReceiptTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ReceiptTab> createState() => _ReceiptTabState();
}

class _ReceiptTabState extends ConsumerState<ReceiptTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        ref.read(invoiceProvider.notifier).fetchMoreReceipt();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final invoiceState = ref.watch(invoiceProvider);
          return invoiceState.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            noData: (startDate, endDate) =>
                const Center(child: Text('Không có dữ liệu')),
            data: (bills, receipts, startDate, endDate) {
              if (receipts.isEmpty) {
                return const Center(child: Text('Không có dữ liệu'));
              }
              return ListView.separated(
                controller: _scrollController,
                itemCount: receipts.length,
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1.125, height: 0),
                itemBuilder: (context, index) {
                  String receiptId = receipts[index].id.toString();
                  DateTime date = receipts[index].dateCreated;
                  String dateCreated =
                      '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}';
                  String totalCost = NumberFormat.currency(locale: 'vi')
                      .format(receipts[index].totalCost)
                      .toString();
                  return SizedBox(
                    height: 70,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.fromLTRB(12, 8, 12, 16),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('#$receiptId'),
                                const SizedBox(height: 8),
                                Text(
                                  dateCreated,
                                  style: const TextStyle(
                                      fontSize: 14, color: kNeutralColor),
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
                                  totalCost,
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                'Nhập',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
