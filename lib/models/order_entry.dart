class OrderEntry {
  final double price, qty;
  OrderEntry(this.price, this.qty);
  factory OrderEntry.fromJson(List<dynamic> j) => OrderEntry(
    double.parse(j[0]),
    double.parse(j[1]),
  );
}