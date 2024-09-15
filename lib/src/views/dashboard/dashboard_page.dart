import 'package:bni_trading/src/models/crypto_price.dart';
import 'package:bni_trading/src/viewmodels/crypto_viewmodel.dart';
import 'package:bni_trading/src/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<FlSpot> spots = [];

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<CryptoViewmodel>(context, listen: false);
    viewModel.subscribe('{"action":"subscribe", "symbols":"ETH-USD, BTC-USD"}');
  }

  @override
  void dispose() {
    final viewModel = Provider.of<CryptoViewmodel>(context, listen: false);
    viewModel.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CryptoViewmodel>(
        builder: (context, viewModel, child) {
          CryptoPrice? btcPrice = viewModel.btcPrice;
          double? chartMinX;
          double? chartMinY;
          double? chartMaxX;
          double? chartMaxY;

          if (btcPrice != null) {
            btcPrice.chart ??= [];

            if (btcPrice.chart!.length > 200) {
              btcPrice.chart!.removeRange(0, 100);
            }

            double x = (btcPrice.timeInt ?? 0) -
                ((btcPrice.timeInt ?? 0) % 1000).toDouble();
            double y = (btcPrice.lastPrice ?? 0).toDouble();
            FlSpot point = FlSpot(x, y);
            spots.add(point);
            btcPrice.chart = spots;

            double minY =
                spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 100;
            double maxY =
                spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 100;

            btcPrice.maxY = maxY;
            btcPrice.minY = minY;

            chartMinX =
                (btcPrice.chart ?? []).isEmpty ? 0 : (btcPrice.chart?.first.x)!;
            chartMinY = ((btcPrice.minY) ?? 0).ceilToDouble() - 5;
            chartMaxX = (btcPrice.chart ?? []).isEmpty
                ? 0
                : (btcPrice.chart?.last.x)! + 1000;
            chartMaxY = btcPrice.maxY!.ceilToDouble() + 5;

            return LineChart(
              LineChartData(
                minX: chartMinX,
                minY: chartMinY,
                maxX: chartMaxX,
                maxY: chartMaxY,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        return LineTooltipItem(
                          '${DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt())}, ${touchedSpot.y}',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                    getTooltipColor: (touchedSpot) =>
                        Colors.blueGrey.withOpacity(0.8),
                    showOnTopOfTheChartBoxArea: false,
                  ),
                  touchSpotThreshold: 20,
                ),
                gridData: FlGridData(
                  show: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[350],
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[350],
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: (spots.length > 20) ? false : true,
                      interval: 6000,
                      getTitlesWidget: (value, meta) {
                        DateTime date =
                            DateTime.fromMillisecondsSinceEpoch(value.toInt());
                        String text = DateFormat('HH:mm:ss').format(date);
                        return Text(
                          text,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 60,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          NumberFormat("#,###", "en_US").format(value),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                    top: BorderSide.none,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: false,
                    color: AppColors.primary,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                            color: AppColors.secondary,
                            strokeColor: AppColors.secondary,
                            strokeWidth: 1);
                      },
                      checkToShowDot: (spot, barData) {
                        return spot == spots.last;
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.teal.withOpacity(0.4),
                          Colors.teal.withOpacity(0.2),
                        ],
                      ),
                    ),
                    spots: spots,
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 1000),
            ).addPd(all: 10);
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              AppStyles.yGapSm,
              Text(
                "Loading...",
                style: AppStyles.primBold(16),
              )
            ],
          ));
        },
      ),
    );
  }
}
