import 'dart:async';
import 'package:flutter/material.dart';
import '../services/platform_service.dart';
import '../widgets/loading_animation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? battery;
  String? device;
  String? os;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    setState(() {
      isLoading = true;
    });

    final info = await PlatformService.getDeviceInfo();

    setState(() {
      battery = '${info['battery']}%';
      device = info['device'];
      os = info['os'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: isLoading
            ? const LoadingAnimation()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Battery: $battery'),
            Text('Device: $device'),
            Text('OS: $os'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchDeviceInfo,
              child: const Text('Refresh Info'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/sensor'),
              child: const Text('Go to Sensor Info'),
            ),
          ],
        ),
      ),
    );
  }
}
