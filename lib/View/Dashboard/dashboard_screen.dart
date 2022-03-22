import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/product_tile.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/View/Dashboard/out_of_stock_screen.dart';
import 'package:gscm_store_owner/ViewModel/Statistics/statistics_notifier.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool isDailyGraph = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildChart(),
                const SizedBox(height: 24),
                _buildNoosProduct(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kNeutralColor100,
        boxShadow: [
          BoxShadow(
            color: kNeutralColor.withOpacity(0.2),
            offset: const Offset(0, 7),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doanh thu',
            style: kListTilePrimaryText.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: kNeutralColor200,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                _buildGraphButton(true),
                _buildGraphButton(false),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Consumer(builder: (context, ref, child) {
            List<ChartData> chartData = [];
            if (isDailyGraph) {
              final dailyRevenue = ref.watch(
                  statisticsProvider.select((value) => value.dailyRevenue));
              chartData = dailyRevenue
                  .map((e) => ChartData(
                      x: '${e.date.day}/${e.date.month}', y: e.revenue))
                  .toList();
            } else {
              final monthlyRevenue = ref.watch(
                  statisticsProvider.select((value) => value.monthlyRevenue));
              chartData = monthlyRevenue
                  .map((e) => ChartData(
                      x: 'Thg${e.date.month} ${e.date.year}', y: e.revenue))
                  .toList();
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  numberFormat: NumberFormat.compact(),
                ),
                enableAxisAnimation: true,
                series: <ChartSeries>[
                  SplineAreaSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (data, _) => data.x,
                    yValueMapper: (data, _) => data.y,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: (isDailyGraph)
                          ? [kPrimaryColor, kPrimaryColor.withOpacity(0.1)]
                          : [kDangerColor, kDangerColor.withOpacity(0.1)],
                    ),
                    borderDrawMode: BorderDrawMode.top,
                    borderColor: (isDailyGraph) ? kPrimaryColor : kDangerColor,
                    borderWidth: 2,
                    opacity: 0.7,
                    name: (isDailyGraph) ? 'Daily Revenue' : 'Monthly Revenue',
                    splineType: SplineType.cardinal,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGraphButton(bool isDailyBtn) {
    return Expanded(
      child: TextButton(
        onPressed: () => setState(() => isDailyGraph = !isDailyGraph),
        child: Center(
          child: Text(
            (isDailyBtn) ? 'Ngày' : 'Tháng',
            style: TextStyle(
              color: (isDailyGraph ^ isDailyBtn) ? kPrimaryColor : kWhite,
            ),
          ),
        ),
        style: TextButton.styleFrom(
            backgroundColor: (isDailyGraph ^ isDailyBtn)
                ? Colors.transparent
                : kPrimaryColor,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
      ),
    );
  }

  Widget _buildNoosProduct() {
    return Consumer(builder: (context, ref, child) {
      final noosProducts =
          ref.watch(statisticsProvider.select((value) => value.noosProducts));
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: kNeutralColor100,
          boxShadow: [
            BoxShadow(
              color: kNeutralColor.withOpacity(0.2),
              offset: const Offset(0, 7),
              blurRadius: 12,
              spreadRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Hàng sắp hết',
                  style: kListTilePrimaryText.copyWith(fontSize: 16),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Get.to(() => const OutOfStockScreen()),
                      splashFactory: NoSplash.splashFactory,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Xem thêm',
                            style: kListTileSecondaryText.copyWith(
                                color: kPrimaryColor, fontSize: 13),
                          ),
                          Icon(Icons.chevron_right_rounded, color: kPrimaryColor),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (noosProducts.length < 5) ? noosProducts.length : 5,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                thickness: 1.125,
              ),
              itemBuilder: (context, index) {
                if (noosProducts.isEmpty) {
                  return const ListTile(
                    title: Text('Không có sản phẩm nào'),
                  );
                }
                return ProductTile(product: noosProducts[index]);
              },
            ),
          ],
        ),
      );
    });
  }
}

class ChartData {
  final String x;
  final num? y;

  ChartData({required this.x, this.y});
}
