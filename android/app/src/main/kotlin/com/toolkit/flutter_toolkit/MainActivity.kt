package com.toolkit.flutter_toolkit

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec
import java.lang.Thread.sleep
import java.util.Random
import java.util.Timer
import kotlin.concurrent.schedule

class MainActivity : FlutterActivity() {

    private val MehtChannel = "com.xiaoxin.toolkit/method_channel"
    private val BasicChannel = "com.xiaoxin.flutter_toolkit/basic_channel"
    private val EventChannel = "com.xiaoxin.flutter_toolkit/event_channel"
    var basicBool = false;

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MehtChannel)
            .setMethodCallHandler { call, result ->
                if (call.method == "methodChannel") {
                    var message = call.argument<String>("message")
                    var resultMsg = "原生返回的数据 ${Random().nextDouble()}  flutter 发送的数据是 ${message}"
                    result.success(resultMsg)
                }
            }

        // basic
        var basicMessageChannel = BasicMessageChannel(flutterEngine.dartExecutor.binaryMessenger, BasicChannel, StringCodec.INSTANCE)
        basicMessageChannel.setMessageHandler { message, reply ->
            var flutterMessage = message;
            var response = "原生返回的信息basic ${flutterMessage}  ${Random().nextDouble()}"
            reply.reply(response) // 回复
            if (!basicBool) {
                basicBool = true;
                Thread {
                    while (basicBool) {
                        sleep(100)
                        runOnUiThread {
                            // 发送消息到flutter
                            basicMessageChannel.send("使用 basicchannel 的send 方法发送的数据，原生发送的消息basic  ${Random().nextDouble()}")
                        }
                    }
                }.start()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EventChannel)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    // flutter 端开始监听
                    Timer().schedule(0, 1000) {
                        var random = Random().nextDouble()
                        var map = mapOf("data" to random.toBits())
                        // 持续发送数据
                        runOnUiThread { events?.success(map) }
                    }
                }

                override fun onCancel(arguments: Any?) {
                    // flutter 取消监听
                    print("取消监听")
                }
            })


    }

}
