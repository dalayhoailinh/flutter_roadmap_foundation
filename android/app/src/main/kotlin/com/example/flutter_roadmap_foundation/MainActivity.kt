package com.example.flutter_roadmap_foundation

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    // This string is the "address" of the channel.
    // It MUST be identical on both sides (Dart and Kotlin) — case-sensitive.
    private val DEVICE_CHANNEL = "com.example.roadmap/device"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DEVICE_CHANNEL,
        ).setMethodCallHandler { call, result ->
            // call.method is the String we pass from Dart: "getDeviceInfo"
            when (call.method) {
                "getDeviceInfo" -> {
                    // Build.MANUFACTURER = "samsung" / "Google" / "OnePlus" ...
                    val brand = Build.MANUFACTURER
                        .replaceFirstChar { it.uppercase() } // "samsung" → "Samsung"
                    val model = Build.MODEL               // e.g. "SM-S928B"
                    val release = Build.VERSION.RELEASE   // e.g. "14"
                    val sdk = Build.VERSION.SDK_INT        // e.g. 34
                    // result.success() sends the reply back across the bridge
                    result.success("$brand $model · Android $release (API $sdk)")
                }
                else -> result.notImplemented() // Required for any unrecognized method
            }
        }
    }
}