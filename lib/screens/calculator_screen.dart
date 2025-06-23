import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/trading_provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen();
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _sym = 'BTCUSDT';
  bool _isBuy = true;
  final _ctrl = TextEditingController();
  double _result = 0, _fee = 0;

  void _calc() {
    final amt = double.tryParse(_ctrl.text) ?? 0;
    const double min = 10.0, max = 10000.0;
    if (amt < min || amt > max) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cantidad debe estar entre \$${min.toStringAsFixed(0)} y \$${max.toStringAsFixed(0)}',
          ),
        ),
      );
      return;
    }
    final prov = context.read<TradingProvider>();
    final raw = prov.calculate(_sym, _isBuy, amt);
    setState(() {
      _fee = amt * prov.feeRate;
      _result = raw;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(symbol: '', decimalDigits: 6);
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _sym,
              onChanged: (v) => setState(() => _sym = v!),
              items: const [
                DropdownMenuItem(value: 'BTCUSDT', child: Text('BTC/USDT')),
                DropdownMenuItem(value: 'ETHUSDT', child: Text('ETH/USDT')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Buy'),
                  selected: _isBuy,
                  onSelected: (v) => setState(() => _isBuy = true),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Sell'),
                  selected: !_isBuy,
                  onSelected: (v) => setState(() => _isBuy = false),
                ),
              ],
            ),
            TextField(
              controller: _ctrl,
              decoration: const InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _calc, child: const Text('Calcular')),
            const SizedBox(height: 16),
            Text("Resultado: ${fmt.format(_result)} ${_isBuy ? _sym.replaceAll('USDT', '') : 'USDT'}"),
            Text("Fee ≈ ${_fee.toStringAsFixed(6)}"),
          ],
        ),
      ),
    );
  }
}
