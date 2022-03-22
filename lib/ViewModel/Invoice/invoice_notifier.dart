import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/invoice_api.dart';
import 'package:gscm_store_owner/Api/store_api.dart';
import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Model/bill.dart';
import 'package:gscm_store_owner/Model/receipt.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import '../../Model/store.dart';
import 'invoice_state.dart';

final invoiceProvider =
    StateNotifierProvider<InvoiceNotifier, InvoiceState>((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  final stores = ref.watch(storeProvider);
  return brandState.maybeWhen(
    orElse: () => InvoiceNotifier(null, []),
    selected: (currentBrand) {
      return InvoiceNotifier(currentBrand.id, stores);
    },
  );
});

class InvoiceNotifier extends StateNotifier<InvoiceState> {
  int? brandId;
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(const Duration(days: 92));
  InvoiceService invoiceDAO = InvoiceService();
  StoreService storeDAO = StoreService();
  List<Store> stores = [];
  late Store chosenStore;
  int pageIndexBill = Metadata.pageIndex;
  int pageIndexReceipt = Metadata.pageIndex;
  int totalPageBill = 1;
  int totalPageReceipt = 1;
  List<Bill> bills = [];
  List<Receipt> receipts = [];

  InvoiceNotifier(this.brandId, this.stores)
      : super(const InvoiceState.loading()) {
    if (brandId != null) {
      init();
    }
  }

  void init() async {
    await fetchStores();
    if (stores.isEmpty) {
      state = InvoiceState.noData(startDate, endDate);
    } else {
      chosenStore = stores[0];
      fetchInvoice();
    }
  }

  Future<void> fetchStores() async {
    final res = await storeDAO.fetchStores(brandId!) as List;
    stores = res.map((store) => Store.fromJson(store)).toList();
  }

  void setDateRange(DateTimeRange range) {
    state = const InvoiceState.loading();
    startDate = range.start;
    endDate = range.end;
    fetchInvoice();
  }

  void setChosenStore(Store chosenStore) {
    state = const InvoiceState.loading();
    this.chosenStore = chosenStore;
    fetchInvoice();
  }

  void fetchInvoice() async {
    await fetchBill(chosenStore.id);
    await fetchReceipt(chosenStore.id);
    state = InvoiceState.data(
      bills: bills,
      receipts: receipts,
      startDate: startDate,
      endDate: endDate,
      stores: stores,
      chosenStore: chosenStore,
    );
  }

  Future<void> fetchBill(int storeId) async {
    final billRes = await invoiceDAO.fetchBill(
      storeId: storeId,
      startDate: startDate,
      endDate: endDate,
      pageIndex: pageIndexBill,
    );
    pageIndexBill = billRes['pageIndex'] as int;
    totalPageBill = billRes['totalPage'] as int;
    bills =
        (billRes['data'] as List).map((bill) => Bill.fromJson(bill)).toList();
  }

  Future<void> fetchReceipt(int storeId) async {
    final receiptRes = await invoiceDAO.fetchReceipt(
      startDate: startDate,
      endDate: endDate,
      storeId: storeId,
      pageIndex: pageIndexReceipt,
    );
    pageIndexReceipt = receiptRes['pageIndex'];
    totalPageReceipt = receiptRes['totalPage'];
    receipts = (receiptRes['data'] as List)
        .map((receipt) => Receipt.fromJson(receipt))
        .toList();
  }

  void fetchMoreBill() async {
    if (pageIndexBill < totalPageBill) {
      ++pageIndexBill;
      final billRes = await invoiceDAO.fetchBill(
        storeId: chosenStore.id,
        startDate: startDate,
        endDate: endDate,
        pageIndex: pageIndexBill,
      );
      pageIndexBill = billRes['pageIndex'] as int;
      totalPageBill = billRes['totalPage'] as int;
      bills.addAll((billRes['data'] as List)
          .map((bill) => Bill.fromJson(bill))
          .toList());
      state = InvoiceState.data(
        bills: bills,
        receipts: receipts,
        startDate: startDate,
        endDate: endDate,
        stores: stores,
        chosenStore: chosenStore,
      );
    }
  }

  void fetchMoreReceipt() async {
    if (pageIndexReceipt < totalPageReceipt) {
      ++pageIndexReceipt;
      final receiptRes = await invoiceDAO.fetchReceipt(
        startDate: startDate,
        endDate: endDate,
        storeId: chosenStore.id,
        pageIndex: pageIndexReceipt,
      );
      pageIndexReceipt = receiptRes['pageIndex'];
      totalPageReceipt = receiptRes['totalPage'];
      receipts.addAll((receiptRes['data'] as List)
          .map((receipt) => Receipt.fromJson(receipt))
          .toList());
      state = InvoiceState.data(
        bills: bills,
        receipts: receipts,
        startDate: startDate,
        endDate: endDate,
        stores: stores,
        chosenStore: chosenStore,
      );
    }
  }
}
