import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gscm_store_owner/Model/product.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState{
  const factory ProductState.loading() = _Loading;
  const factory ProductState.data(List<Product> products, bool isLoadingMore) = _Data;
}