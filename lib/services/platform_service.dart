import 'package:flutter/services.dart';

class PlatformService {
  static const _channel = MethodChannel('device_info_sensor');

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final result = await _channel.invokeMethod('getDeviceInfo');
    return Map<String, dynamic>.from(result);
  }

  static Future<bool> toggleFlashlight() async {
    final result = await _channel.invokeMethod('toggleFlash');
    return result == true;
  }
}
