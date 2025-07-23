import 'package:flutter/material.dart';
import '../services/platform_service.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  bool isFlashOn = false;

  void toggleFlash() async {
    final result = await PlatformService.toggleFlashlight();
    setState(() {
      isFlashOn = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensor Info')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFlashOn ? Icons.flashlight_on : Icons.flashlight_off,
              size: 80,
              color: isFlashOn ? Colors.yellow : Colors.grey,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleFlash,
              child: Text(isFlashOn ? 'Turn Flash OFF' : 'Turn Flash ON'),
            )
          ],
        ),
      ),
    );
  }
}
