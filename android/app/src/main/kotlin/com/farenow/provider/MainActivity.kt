package com.farenow.provider

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.os.Handler
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import com.facebook.FacebookSdk
import com.farenow.provider.MyFirebaseMessagingService

//import io.flutter.plugins.GeneratedPluginRegistrant


private const val FLUTTER_ENGINE_ID = "flutter_engine"
private const val CHANNEL = "flutter.native/helper"
public var MOBILE_ON = false
lateinit var MESSANGER: BinaryMessenger
lateinit var CHANNEL_ID: MethodChannel

class MainActivity : FlutterActivity() {

    var receiver: WifiLevelReceiver? = null
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        receiver = WifiLevelReceiver(getFlutterView())
        FacebookSdk.sdkInitialize(getApplicationContext())
        registerReceiver(receiver, IntentFilter("GET_SIGNAL_STRENGTH"))
        MOBILE_ON = true
        CHANNEL_ID = MethodChannel(getFlutterView(), CHANNEL)
        val intent = intent
        val extras = intent.extras
        if (getIntent().hasExtra("msg")) {
            Handler().postDelayed({
                var func = getFlutterView()
                val data: String = getIntent().getStringExtra("msg").toString()
                Log.d("payload ::", "onCreate: $data")
                //                Toast.makeText(MainActivity.this, data, Toast.LENGTH_SHORT).show();
                setData(getIntent().getStringExtra("msg"),func)
            }, 8000)
        }
//        CHANNEL_ID.setMethodCallHandler { call, result ->
//            run {
//                if (call.method.equals("flutterToNative")) {
//                    Log.d("", "")
//                    if (call.argument<String>("text1").equals("true")) {
//                        NotificationManagerCompat.from(this).cancelAll()
//                    }
//                }
//            }
//        }
    }
    private fun setData(level: String?, func: BinaryMessenger) {
//        if (MOBILE_ON) {
//            MethodChannel(func, CHANNEL).setMethodCallHandler { call, result ->
//                run {
//                    if (call.method == "helloFromNativeCode") {
//                        result.success(level)
//                        MOBILE_ON = true
//                    }
//                }
//            }
//        }
        CHANNEL_ID.invokeMethod("open_notification", level, object : MethodChannel.Result {
            override fun success(o: Any?) {
                Log.d("Results", o.toString())
            }

            override fun error(s: String, s1: String?, o: Any?) {}
            override fun notImplemented() {}
        })
    }
    fun getFlutterView(): BinaryMessenger {
        MESSANGER = flutterEngine!!.dartExecutor.binaryMessenger;
        return MESSANGER;
    }
    private fun helloFromNativeCode(): String {
        return "Hello from Native Android Code"
    }
    override fun onDestroy() {
        super.onDestroy()
        var intent: Intent = Intent(applicationContext, MyFirebaseMessagingService::class.java)
        startService(intent)
//        Toast.makeText(applicationContext, "Destroy", Toast.LENGTH_LONG).show()
    }


    }


class WifiLevelReceiver(flutterView: BinaryMessenger) : BroadcastReceiver() {

    var func = flutterView
    override fun onReceive(context: Context?, intent: Intent) {
        if (intent.getAction().equals("GET_SIGNAL_STRENGTH")) {
            val level: String? = intent.getStringExtra("LEVEL_DATA")
            setData(level, func)
            Log.d("", "");
            // Show it in GraphView
        }
    }


    private fun setData(level: String?, func: BinaryMessenger) {
//        if (MOBILE_ON) {
//            MethodChannel(func, CHANNEL).setMethodCallHandler { call, result ->
//                run {
//                    if (call.method == "helloFromNativeCode") {
//                        result.success(level)
//                        MOBILE_ON = true
//                    }
//                }
//            }
//        }
        CHANNEL_ID.invokeMethod("open_notification", level, object : MethodChannel.Result {
            override fun success(o: Any?) {
                Log.d("Results", o.toString())
            }

            override fun error(s: String, s1: String?, o: Any?) {}
            override fun notImplemented() {}
        })
    }

}
