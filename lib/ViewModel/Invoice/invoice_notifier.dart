import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Api/invoice_api.dart';
import 'package:gscm_store_owner/Constant/metadata.dart';
import 'package:gscm_store_owner/Model/bill.dart';
import 'package:gscm_store_owner/Model/receipt.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';
import '../../Model/store.dart';
import 'invoice_state.dart';

final invoiceProvider =
    StateNotifierProvider<InvoiceNotifier, InvoiceState>((ref) {
  final brandState = ref.watch(brandNotifierProvider);
  return brandState.maybeWhen(
    orElse: () => InvoiceNotifier(null, []),
    selected: (currentBrand) {
      final stores = ref.watch(storeProvider);
      return InvoiceNotifier(currentBrand.id, stores);
    },
  );
});

class InvoiceNotifier extends StateNotifier<InvoiceState> {
  int? brandId;
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(const Duration(days: 92));
  InvoiceService invoiceDAO = InvoiceService();
  late List<Store> stores;
  late int currentStoreId;
  int pageIdexBill = Metadata.pageIndex;
  int pageIndexReceipt = Metadata.pageIndex;
  int totalPageBill = 1;
  int totalPageReceipt = 1;
  List<Bill> bills = [];
  List<Receipt> receipts = [];

  InvoiceNotifier(this.brandId, this.stores)
      : super(const InvoiceState.loading()) {
    if (brandId != null && stores.isNotEmpty) {
      currentStoreId = stores[0].id;
      fetchInvoice();
    } else {
      debugPrint('invoice no data');
      state = InvoiceState.noData(startDate, endDate);
    }
  }

  void setDateRange(DateTimeRange range) {
    startDate = range.start;
    endDate = range.end;
    fetchInvoice();
  }

  void setStoreId(int storeId) {
    currentStoreId = storeId;
    fetchInvoice();
  }

  void fetchInvoice() {
    fetchBill(currentStoreId);
    fetchReceipt(currentStoreId);
    state = InvoiceState.data(
      bills: bills,
      receipts: receipts,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void fetchBill(int storeId) async {
    final billRes = await invoiceDAO.fetchBill(
      storeId: storeId,
      startDate: startDate,
      endDate: endDate,
    );
    pageIdexBill = billRes['pageIndex'] as int;
    totalPageBill = billRes['totalPage'] as int;
    bills =
        (billRes['data'] as List).map((bill) => Bill.fromJson(bill)).toList();
  }

  void fetchReceipt(int storeId) async {
    final receiptRes = await invoiceDAO.fetchReceipt(
      startDate: startDate,
      endDate: endDate,
      storeId: storeId,
    );
    pageIndexReceipt = receiptRes['pageIndex'];
    totalPageReceipt = receiptRes['totalPage'];
    receipts = (receiptRes['data'] as List)
        .map((receipt) => Receipt.fromJson(receipt))
        .toList();
  }

  void fetchMoreBill() {
    if (pageIdexBill <= totalPageBill) {
      ++pageIdexBill;
      fetchBill(currentStoreId);
      state = InvoiceState.data(
        bills: bills,
        receipts: receipts,
        startDate: startDate,
        endDate: endDate,
      );
    }
  }

  void fetchMoreReceipt() {
    if (pageIndexReceipt <= totalPageReceipt) {
      ++pageIndexReceipt;
      fetchReceipt(currentStoreId);
      state = InvoiceState.data(
        bills: bills,
        receipts: receipts,
        startDate: startDate,
        endDate: endDate,
      );
    }
  }
}
