import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/brand.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_notifier.dart';
import 'package:gscm_store_owner/ViewModel/Brand/brand_notifier.dart';

class BrandSelection extends ConsumerStatefulWidget {
  const BrandSelection({Key? key}) : super(key: key);

  @override
  ConsumerState<BrandSelection> createState() => _BrandSelectionState();
}

class _BrandSelectionState extends ConsumerState<BrandSelection> {
  int selectedBrandId = -1;

  @override
  Widget build(BuildContext context) {
    final brandState = ref.watch(brandNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: brandState.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            needSelection: (workingBrands) => Column(
              children: [
                const Text(
                  'Thương hiệu của bạn',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    children: [
                      if (workingBrands.isNotEmpty) ...[
                        _buildSectionTitle('Đang hoạt động', kPrimaryColor),
                        ...workingBrands
                            .map((brand) => _buildBrandTile(
                                  brand: brand,
                                  color: kPrimaryColor,
                                  isSelected: brand.id == selectedBrandId,
                                ))
                            .toList(),
                        const SizedBox(height: 35),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory),
                        child: const Text(
                          'Đổi tài khoản',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        onPressed: () {
                          ref.read(appStartupProvider.notifier).logout();
                        },
                      ),
                      FloatingActionButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          if (selectedBrandId != -1) {
                            Brand selectedBrand = workingBrands
                                .where((brand) => brand.id == selectedBrandId)
                                .first;
                            ref
                                .read(brandNotifierProvider.notifier)
                                .setSelectedBrand(selectedBrand);
                          }
                        },
                        child: const Icon(
                          Icons.chevron_right,
                          color: kWhite,
                          size: 40,
                        ),
                        backgroundColor: (selectedBrandId != -1)
                            ? kPrimaryColor
                            : Colors.grey[300],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Row(
      children: [
        Text(
          '$title   ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 20,
            width: 20,
            color: color,
          ),
        )
      ],
    );
  }

  Widget _buildBrandTile({
    required Brand brand,
    required Color color,
    bool isSelected = false,
    bool isWorkingBrand = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          if (isWorkingBrand) {
            setState(() {
              selectedBrandId = brand.id;
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
              color: isSelected ? color : kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: color,
                style: BorderStyle.solid,
                width: 2,
              )),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                brand.name,
                style: TextStyle(
                  color: isSelected ? kWhite : color,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              if (isSelected)
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kWhite,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: kWhite,
                    size: 25,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
