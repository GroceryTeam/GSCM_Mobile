import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/ViewModel/Invoice/invoice_notifier.dart';
import 'package:intl/intl.dart';

class BillTab extends ConsumerStatefulWidget {
  const BillTab({Key? key}) : super(key: key);

  @override
  ConsumerState<BillTab> createState() => _BillTabState();
}

class _BillTabState extends ConsumerState<BillTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        ref.read(invoiceProvider.notifier).fetchMoreBill();
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
      body: Consumer(builder: (context, ref, child) {
        final invoiceState = ref.watch(invoiceProvider);
        return invoiceState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          noData: (startDate, endDate) =>
              const Center(child: Text('Không có dữ liệu')),
          data: (bills, receipts, startDate, endDate) {
            if (bills.isEmpty) {
              return const Center(child: Text('Không có dữ liệu'));
            }
            return ListView.separated(
              controller: _scrollController,
              itemCount: bills.length,
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1.125, height: 0),
              itemBuilder: (context, index) {
                String billId = bills[index].id.toString();
                String cashierName = bills[index].cashierName;
                String totalPrice = NumberFormat.currency(locale: 'vi')
                    .format(bills[index].totalPrice)
                    .toString();
                DateTime date = bills[index].dateCreated;
                String dateCreated =
                    '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}';
                return SizedBox(
                  height: 88,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.fromLTRB(12, 8, 12, 16),
                    title: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('#$billId'),
                              const SizedBox(height: 6),
                              Text(
                                cashierName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: kNeutralColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                dateCreated,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: kNeutralColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                totalPrice,
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Bán',
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
      }),
    );
  }
}
