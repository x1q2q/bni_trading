import 'package:fl_chart/fl_chart.dart';

class CryptoPrice {
  final String? tickerCode;
  final double? lastPrice;
  final double? qtyTrade;
  final double? dailyChangePerc;
  final double? dailyDiffPrice;
  final DateTime? timestamp;
  String? icon;
  final int? timeInt;
  double? maxY;
  double? minY;
  List<FlSpot>? chart;

  CryptoPrice(
      {required this.tickerCode,
      required this.lastPrice,
      required this.qtyTrade,
      required this.dailyChangePerc,
      required this.dailyDiffPrice,
      this.timestamp,
      required this.icon,
      required this.timeInt,
      this.maxY,
      this.minY});

  factory CryptoPrice.fromJson(Map<String, dynamic> json) {
    return CryptoPrice(
        tickerCode: json['s'] ?? '',
        lastPrice: double.parse(json['p'] ?? '0.0'),
        qtyTrade: double.parse(json['q'] ?? '0.0'),
        dailyChangePerc: double.parse(json['dc'] ?? '0.0'),
        dailyDiffPrice: double.parse(json['dd'] ?? '0.0'),
        timestamp: DateTime.fromMillisecondsSinceEpoch(json['t'] ?? 0),
        icon: json['icon'] ?? '',
        timeInt: json['t'] ?? 0,
        maxY: json["maxY"] ?? 0,
        minY: json["minY"] ?? 0);
  }
}
