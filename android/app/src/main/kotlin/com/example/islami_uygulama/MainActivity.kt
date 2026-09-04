package com.example.islami_uygulama

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.islami_uygulama/test"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "testNotification") {
                    result.success(true)
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleTestIntent(intent)
    }

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        handleTestIntent(intent)
    }

    private fun handleTestIntent(intent: Intent?) {
        if (intent?.getBooleanExtra("test_notification", false) == true) {
            val channel = MethodChannel(
                flutterEngine?.dartExecutor?.binaryMessenger ?: return,
                CHANNEL
            )
            channel.invokeMethod("testNotification", null)
        }
    }
}
