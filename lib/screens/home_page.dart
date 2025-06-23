import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'order_book_screen.dart';
import 'calculator_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  static const _screens = [
    DashboardScreen(),
    OrderBookScreen(),
    CalculatorScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.format_list_numbered), label: 'Order Book'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculadora'),
        ],
      ),
    );
  }
}