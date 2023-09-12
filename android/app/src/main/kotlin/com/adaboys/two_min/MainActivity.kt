package com.adaboys.two_min

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.adaboys.two_min/flavor";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            result.success(BuildConfig.FLAVOR)
//            if (call.method == "getFlavor") {
//                result.success(BuildConfig.FLAVOR)
//            } else {
//                result.notImplemented()
//            }
        }
    }
}
