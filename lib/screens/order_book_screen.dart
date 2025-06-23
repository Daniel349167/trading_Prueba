import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trading_provider.dart';
import '../widgets/order_row.dart';

class OrderBookScreen extends StatefulWidget {
  const OrderBookScreen();
  @override
  State<OrderBookScreen> createState() => _OrderBookScreenState();
}

class _OrderBookScreenState extends State<OrderBookScreen> {
  String _sym = 'BTCUSDT';

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TradingProvider>();
    final bids = prov.bids(_sym), asks = prov.asks(_sym);
    final spread = (bids.isNotEmpty && asks.isNotEmpty)
        ? (asks.first.price - bids.first.price)
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Book - ${_sym.replaceAll('USDT', '/USDT')}'),
        actions: [
          DropdownButton<String>(
            value: _sym,
            dropdownColor: Colors.grey[900],
            underline: const SizedBox(),
            onChanged: (v) => setState(() => _sym = v!),
            items: const [
              DropdownMenuItem(value: 'BTCUSDT', child: Text('BTC/USDT')),
              DropdownMenuItem(value: 'ETHUSDT', child: Text('ETH/USDT')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('ASKS', style: TextStyle(color: Colors.red)),
                ),
                ...asks.map((e) => OrderRow(e, isAsk: true)),
                Center(child: Text('SPREAD: \$${spread.toStringAsFixed(2)}')),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('BIDS', style: TextStyle(color: Colors.green)),
                ),
                ...bids.map((e) => OrderRow(e, isAsk: false)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
