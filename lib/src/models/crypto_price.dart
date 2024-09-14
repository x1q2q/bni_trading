class CryptoPrice {
  final String? tickerCode;
  final double? lastPrice;
  final double? qtyTrade;
  final double? dailyChangePerc;
  final double? dailyDiffPrice;
  final DateTime? timestamp;

  CryptoPrice(
      {required this.tickerCode,
      required this.lastPrice,
      required this.qtyTrade,
      required this.dailyChangePerc,
      required this.dailyDiffPrice,
      required this.timestamp});

  factory CryptoPrice.fromJson(Map<String, dynamic> json) {
    return CryptoPrice(
        tickerCode: json['s'] ?? '',
        lastPrice: double.parse(json['p'] ?? '0.0'),
        qtyTrade: double.parse(json['q'] ?? '0.0'),
        dailyChangePerc: double.parse(json['dc'] ?? '0.0'),
        dailyDiffPrice: double.parse(json['dd'] ?? '0.0'),
        timestamp: DateTime.fromMillisecondsSinceEpoch(json['t'] ?? 0));
  }
}
