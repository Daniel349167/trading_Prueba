import 'package:flutter/material.dart';
import '../models/order_entry.dart';

class OrderRow extends StatelessWidget {
  final OrderEntry e;
  final bool isAsk;
  const OrderRow(this.e, {required this.isAsk});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: Colors.grey[850],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(e.price.toStringAsFixed(2), style: TextStyle(color: isAsk ? Colors.red : Colors.green)), Text(e.qty.toStringAsFixed(6)), Text((e.price * e.qty).toStringAsFixed(2))],
      ),
    );
  }
}