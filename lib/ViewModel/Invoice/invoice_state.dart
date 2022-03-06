import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../Model/bill.dart';
import '../../Model/receipt.dart';

part 'invoice_state.freezed.dart';

@freezed
class InvoiceState with _$InvoiceState {
  const factory InvoiceState.loading() = _Loading;
  const factory InvoiceState.data(
      {required List<Bill> bills,
      required List<Receipt> receipts,
      required DateTime startDate,
      required DateTime endDate}) = _Data;
  const factory InvoiceState.noData(
    DateTime startDate,
    DateTime enddate,
  ) = _NoData;
}
