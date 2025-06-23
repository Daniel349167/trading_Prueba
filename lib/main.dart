import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/trading_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TradingProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        splashColor: Colors.transparent,
      ),
      home: const SplashScreen(),
    );
  }
}