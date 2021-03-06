import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Accessories/shimmer_block.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/store.dart';
import 'package:gscm_store_owner/View/Invoice/bill_tab.dart';
import 'package:gscm_store_owner/View/Invoice/receipt_tab.dart';
import 'package:gscm_store_owner/ViewModel/Invoice/invoice_notifier.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hóa đơn'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Thời gian'),
                    const SizedBox(width: 10),
                    Consumer(
                      builder: (context, ref, child) {
                        final invoiceState = ref.watch(invoiceProvider);
                        return InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () async {
                            final range = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 7)),
                            );
                            if (range != null) {
                              ref
                                  .read(invoiceProvider.notifier)
                                  .setDateRange(range);
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                //color: Colors.grey[100],
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(6)),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    invoiceState.when(
                                      loading: () => 'dd/mm/yyyy - dd/mm/yyyy',
                                      data: (bills, receipts, startDate, endDate,
                                              stores, chosenStore) =>
                                          '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
                                      noData: (startDate, endDate) =>
                                          '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.date_range_rounded),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Cửa hàng',
                      style: TextStyle(color: kBlack),
                    ),
                    const SizedBox(width: 10),
                    Consumer(
                      builder: (context, ref, child) {
                        final invoiceState = ref.watch(invoiceProvider);
                        return invoiceState.maybeWhen(
                          orElse: () =>
                              const ShimmerBlock(width: 80, height: 30),
                          data: (bills, receipts, startDate, endDate, stores,
                              chosenStore) {
                            return DropdownButton(
                              
                              value: chosenStore,
                              items: stores
                                  .map(
                                    (store) => DropdownMenuItem(
                                      value: store,
                                      child: Text(store.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (Store? value) {
                                ref
                                    .read(invoiceProvider.notifier)
                                    .setChosenStore(value!);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: kNeutralColor200,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  unselectedLabelColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  tabs: const [
                    Tab(
                      child: Text('Bán'),
                    ),
                    Tab(
                      child: Text('Nhập'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Expanded(
                child: TabBarView(
                  children: [
                    BillTab(),
                    ReceiptTab(),
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
