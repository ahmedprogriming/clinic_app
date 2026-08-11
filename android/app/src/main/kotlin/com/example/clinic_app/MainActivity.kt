package com.example.clinic_app

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "clinic_app/whatsapp"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                // =========================
                // WhatsApp
                // =========================

                "openWhatsApp" -> {

                    val url =
                        call.argument<String>("url")

                    if (url.isNullOrEmpty()) {
                        result.success(false)
                        return@setMethodCallHandler
                    }

                    try {

                        val intent = Intent(
                            Intent.ACTION_VIEW,
                            Uri.parse(url)
                        )

                        startActivity(intent)

                        result.success(true)

                    } catch (e: Exception) {

                        result.success(false)
                    }
                }

                // =========================
                // SMS
                // =========================

               
"openSms" -> {

    val phone = call.argument<String>("phone")
    val message = call.argument<String>("message")

    if (phone.isNullOrEmpty()) {
        result.success(false)
        return@setMethodCallHandler
    }

    try {

        // الطريقة الأساسية
        val intent = Intent(Intent.ACTION_SENDTO).apply {
            data = Uri.parse("smsto:$phone")
            putExtra("sms_body", message ?: "")
        }

        startActivity(intent)

        result.success(true)

    } catch (e: Exception) {

        try {
            // محاولة بديلة لبعض أجهزة Android
            val intent = Intent(Intent.ACTION_VIEW).apply {
                data = Uri.parse("sms:$phone")
                putExtra("sms_body", message ?: "")
            }

            startActivity(intent)

            result.success(true)

        } catch (e2: Exception) {

            result.error(
                "SMS_ERROR",
                "No SMS application found",
                null
            )
        }
    }
}



                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}

