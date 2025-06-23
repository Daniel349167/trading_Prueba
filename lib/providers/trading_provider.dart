import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ticker_data.dart';
import '../models/order_entry.dart';

class TradingProvider extends ChangeNotifier {
  final Map<String, TickerData> _tickers = {};
  final Map<String, List<OrderEntry>> _bids = {};
  final Map<String, List<OrderEntry>> _asks = {};
  final Map<String, List<double>> _history = {};
  final double _feeRate = 0.001;

  // ← Este getter público te permite acceder al feeRate desde fuera
  double get feeRate => _feeRate;

  Timer? _throttle;
  bool _connected = false;
  bool get isConnected => _connected;

  TradingProvider() {
    for (var sym in ['BTCUSDT', 'ETHUSDT']) {
      _history[sym] = [];
      _connectTicker(sym);
      _connectDepth(sym);
    }
  }

  TickerData? getTicker(String sym) => _tickers[sym];
  List<OrderEntry> bids(String sym) => _bids[sym] ?? [];
  List<OrderEntry> asks(String sym) => _asks[sym] ?? [];
  List<double> history(String sym) => _history[sym]!;

  double calculate(String sym, bool isBuy, double amount) {
    final price = _tickers[sym]?.price ?? 0;
    if (price == 0) return 0;
    if (isBuy) {
      return (amount * (1 - _feeRate)) / price;
    } else {
      return (amount * (1 - _feeRate)) * price;
    }
  }

  void _updateAndNotify() {
    if (_throttle?.isActive ?? false) return;
    _throttle = Timer(const Duration(seconds: 2), () {
      notifyListeners();
    });
  }

  void reconnectAll() {
    for (var sym in ['BTCUSDT', 'ETHUSDT']) {
      _connectTicker(sym);
      _connectDepth(sym);
    }
  }

  void _connectTicker(String sym) {
    final ws = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/${sym.toLowerCase()}@ticker',
    );
    _connected = true;
    notifyListeners();

    ws.stream.listen((msg) async {
      final data = TickerData.fromJson(json.decode(msg));
      _tickers[sym] = data;
      final h = _history[sym]!..add(data.price);
      if (h.length > 50) h.removeAt(0);
      final prefs = await SharedPreferences.getInstance();
      prefs.setDouble('${sym}_lastPrice', data.price);
      _updateAndNotify();
    }, onDone: () {
      _connected = false;
      notifyListeners();
      Future.delayed(const Duration(seconds: 5), () => _connectTicker(sym));
    }, onError: (_) {
      _connected = false;
      notifyListeners();
    });
  }

  void _connectDepth(String sym) {
    final ws = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/${sym.toLowerCase()}@depth20@100ms',
    );
    ws.stream.listen((msg) {
      final js = json.decode(msg);
      _bids[sym] = (js['bids'] as List).map((e) => OrderEntry.fromJson(e)).toList();
      _asks[sym] = (js['asks'] as List).map((e) => OrderEntry.fromJson(e)).toList();
      _updateAndNotify();
    }, onDone: () {
      Future.delayed(const Duration(seconds: 5), () => _connectDepth(sym));
    });
  }
}
