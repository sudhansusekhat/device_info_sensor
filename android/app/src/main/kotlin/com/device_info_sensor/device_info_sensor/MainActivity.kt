package com.device_info_sensor.device_info_sensor

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.hardware.camera2.CameraManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "device_info_sensor"
    private var isFlashOn = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    val battery = getBatteryLevel()
                    val device = Build.MODEL
                    val os = "Android ${Build.VERSION.RELEASE}"
                    result.success(mapOf("battery" to battery, "device" to device, "os" to os))
                }
                "toggleFlash" -> {
                    val toggled = toggleFlashlight()
                    result.success(toggled)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    private fun toggleFlashlight(): Boolean {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList[0] // usually back camera

        try {
            isFlashOn = !isFlashOn
            cameraManager.setTorchMode(cameraId, isFlashOn)
        } catch (e: Exception) {
            e.printStackTrace()
            return false
        }
        return isFlashOn
    }
}

