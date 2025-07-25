import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/sensor_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Info & Sensor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
      routes: {
        '/sensor': (context) => const SensorScreen(),
      },
    );
  }
}
