import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/trading_provider.dart';
import '../screens/detail_screen.dart';

class TickerTile extends StatelessWidget {
  final String symbol;
  const TickerTile({required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Consumer<TradingProvider>(
      builder: (_, prov, __) {
        final data = prov.getTicker(symbol);
        if (data == null) return const Center(child: CircularProgressIndicator());
        final fmt = NumberFormat.currency(symbol: '', decimalDigits: 2);
        final isUp = data.changePct >= 0;

        return RefreshIndicator(
          onRefresh: () async => prov.reconnectAll(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                tileColor: Colors.grey[850],
                title: Text(
                  fmt.format(data.price),
                  style: const TextStyle(fontSize: 32, fontFamily: 'RobotoMono'),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data.changePct.toStringAsFixed(2)}%'),
                    Text('Vol: ${NumberFormat.compact().format(data.volume)}'),
                  ],
                ),
                trailing: Icon(
                  isUp ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isUp ? Colors.green : Colors.red,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailScreen(symbol: symbol)),
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: prov.history(symbol)
                            .asMap()
                            .entries
                            .map((e) => FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
