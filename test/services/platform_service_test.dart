import 'package:device_info_sensor/services/platform_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('device_info_sensor');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getDeviceInfo') {
        return {
          'battery': 90,
          'device': 'Pixel Test',
          'os': 'Android 14',
        };
      }
      if (methodCall.method == 'toggleFlash') {
        return true;
      }
      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getDeviceInfo returns correct mocked data', () async {
    final info = await PlatformService.getDeviceInfo();
    expect(info['battery'], 90);
    expect(info['device'], 'Pixel Test');
    expect(info['os'], 'Android 14');
  });

  test('toggleFlashlight returns true', () async {
    final result = await PlatformService.toggleFlashlight();
    expect(result, isTrue);
  });
}
