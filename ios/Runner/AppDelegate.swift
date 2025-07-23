import UIKit
import Flutter
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
    var isFlashOn = false

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "device_info_sensor", binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "getDeviceInfo":
                UIDevice.current.isBatteryMonitoringEnabled = true
                let battery = Int(UIDevice.current.batteryLevel * 100)
                let device = UIDevice.current.name
                let os = UIDevice.current.systemVersion
                result(["battery": battery, "device": device, "os": "iOS \(os)"])
            case "toggleFlash":
                self.toggleFlashlight()
                result(self.isFlashOn)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func toggleFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }

        do {
            try device.lockForConfiguration()
            isFlashOn.toggle()
            try device.setTorchModeOn(level: isFlashOn ? 1.0 : 0.0)
            device.unlockForConfiguration()
        } catch {
            print("Flashlight error: \(error)")
        }
    }
}
