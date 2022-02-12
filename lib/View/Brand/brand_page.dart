import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/View/Brand/brand_loading.dart';
import 'package:gscm_store_owner/View/Brand/brand_selection.dart';
import 'package:gscm_store_owner/View/NotFound/not_found_screen.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';

class BrandPage extends ConsumerWidget {
  const BrandPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandState = ref.watch(brandNotifierProvider);
    return brandState.when(
      initialize: () => const BrandLoading(),
      needSelection: (workingBrands, stoppedBrands) => const BrandSelection(),
      selected: (currentBrand) => const NotFoundScreen(),
    );
  }
}
