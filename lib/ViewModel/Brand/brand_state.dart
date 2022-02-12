import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gscm_store_owner/Model/brand.dart';

part 'brand_state.freezed.dart';

@freezed
class BrandState with _$BrandState {
  const factory BrandState.initialize() = _Initialize;
  const factory BrandState.needSelection(
    List<Brand> workingBrands,
    List<Brand> stoppedBrands,
  ) = _NeedSelection;
  const factory BrandState.selected(Brand currentBrand) = _Selected;
}
