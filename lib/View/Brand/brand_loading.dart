import 'package:flutter/material.dart';
import 'package:gscm_store_owner/Accessories/shimmer_block.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';

class BrandLoading extends StatelessWidget {
  const BrandLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: Column(
            children: [
              const Text(
                'Chọn brand mong muốn',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Text(
                    'Đang hoạt động   ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 20,
                      width: 20,
                      color: kPrimaryColor,
                    ),
                  )
                ],
              ),
              const ShimmerBlock(width: double.infinity, height: 64),
              const ShimmerBlock(width: double.infinity, height: 64),
              /* const SizedBox(height: 35),
              Row(
                children: [
                  const Text(
                    'Ngưng hoạt động   ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 20,
                      width: 20,
                      color: kNeutralColor,
                    ),
                  )
                ],
              ), */
              const ShimmerBlock(width: double.infinity, height: 64),
              const ShimmerBlock(width: double.infinity, height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
