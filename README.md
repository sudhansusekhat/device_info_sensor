# device_info_sensor

Device Info & Sensor App
# 🔋 Device Info & Sensor App

A Flutter app that demonstrates native platform integration using `MethodChannel` to fetch device information and control the flashlight.

---

## 📱 Features

### Dashboard Screen
- 🔋 Battery level
- 📱 Device name
- 💻 OS version
- ⏳ Loading animation

### Sensor Info Screen
- 💡 Toggle flashlight (via native code)
- 🔧 PlatformChannel used for hardware control

---

## 📦 Tech Stack

- **Flutter 3.x**
- Dart
- `MethodChannel` for native communication
- Kotlin (Android)
- Swift (iOS)
- Lottie / CircularProgressIndicator
- Unit Testing with `flutter_test`

---

## 🧪 Unit Tests

- ✅ `test/services/platform_service_test.dart` tests:
    - `getDeviceInfo()`
    - `toggleFlashlight()`

Run tests with:

```bash
flutter test

