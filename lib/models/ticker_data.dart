class TickerData {
  final double price, changePct, volume, open, high, low, close;
  TickerData({
    required this.price,
    required this.changePct,
    required this.volume,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
  factory TickerData.fromJson(Map<String, dynamic> j) => TickerData(
    price: double.parse(j['c']),
    changePct: double.parse(j['P']),
    volume: double.parse(j['v']),
    open: double.parse(j['o']),
    high: double.parse(j['h']),
    low: double.parse(j['l']),
    close: double.parse(j['x']),
  );
}