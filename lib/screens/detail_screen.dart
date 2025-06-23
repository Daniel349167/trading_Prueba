import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/trading_provider.dart';

class DetailScreen extends StatelessWidget {
  final String symbol;
  const DetailScreen({required this.symbol});

  @override
  Widget build(BuildContext context) {
    final d = context.watch<TradingProvider>().getTicker(symbol)!;
    final fmt = NumberFormat.currency(symbol: '', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(title: Text(symbol.replaceAll('USDT', '/USDT'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                fmt.format(d.price),
                key: ValueKey(d.price),
                style: const TextStyle(fontSize: 40, fontFamily: 'RobotoMono'),
              ),
            ),
            const SizedBox(height: 16),
            Text('Open: ${fmt.format(d.open)}'),
            Text('High: ${fmt.format(d.high)}'),
            Text('Low:  ${fmt.format(d.low)}'),
            Text('Close: ${fmt.format(d.close)}'),
            Text('Volumen: ${NumberFormat.compact().format(d.volume)}'),
          ],
        ),
      ),
    );
  }
}
