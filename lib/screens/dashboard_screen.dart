import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trading_provider.dart';
import '../widgets/ticker_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Consumer<TradingProvider>(
            builder: (_, prov, __) => Icon(
              prov.isConnected ? Icons.cloud_done : Icons.cloud_off,
              color: prov.isConnected ? Colors.green : Colors.red,
            ),
          ),
          title: const Text('Trading Dashboard'),
          bottom: const TabBar(tabs: [
            Tab(text: 'BTC/USDT'),
            Tab(text: 'ETH/USDT'),
          ]),
        ),
        body: const TabBarView(
          children: [
            TickerTile(symbol: 'BTCUSDT'),
            TickerTile(symbol: 'ETHUSDT'),
          ],
        ),
      ),
    );
  }
}
