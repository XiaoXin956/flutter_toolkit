import 'package:flutter/services.dart';

class AndroidNative {
  // MethodChannel 通道名称
  static const String _methodChannelName = "com.xiaoxin.toolkit/method_channel";

  static final MethodChannel _methodChannelPlatform = MethodChannel(_methodChannelName);
  // 同步
  static Future<dynamic> callSyncMethodChannel(String msg) async {
    String response = "";
    try {
      final methodChannelPlatform = MethodChannel(_methodChannelName);
      final String result = await methodChannelPlatform.invokeMethod("methodChannel", {"message": msg});
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to get battery level: '${e.message}'.";
    }
    return response;
  }

  // 异步
  static void callAsyncMethodChannel(String msg, {required Function(dynamic) resultFun}) async {
    String response = "";
    try {
      Future<String?> result = _methodChannelPlatform.invokeMethod("methodChannel", {"message": msg});
      result.then((value) {
        response = value.toString();
        resultFun(response);
      });
    } on PlatformException catch (e) {
      response = "Failed to get battery level: '${e.message}'.";
      resultFun(response);
    }
  }

  // BasicMessageChannel 通道名称
  static const String _basicMessageChannelName = "com.xiaoxin.flutter_toolkit/basic_channel";
  static BasicMessageChannel _basicMessageChannel = BasicMessageChannel(_basicMessageChannelName, StringCodec());

  // 同步
  static Future<dynamic> callSyncBasicMessageChannel({String message = ""}) async {
    _basicMessageChannel.setMessageHandler((message) {

      return message;
    });
    dynamic result = await _basicMessageChannel.send("${message}");
    print(result);
    return result;
  }

  // 异步
  static callAsyncBasicMessageChannel({String message = "",Function(dynamic)? result}) async {
    _basicMessageChannel.setMessageHandler((message){
      print("原生发来了消息        ${message}");
      result!(message);
      return Future(() => message);
    });
    _basicMessageChannel.send("${message}").then((value) => result!(value));
  }

  // EventChannel
  static const String _eventChannelName = "com.xiaoxin.flutter_toolkit/event_channel";

  static Stream<dynamic> callEventChannel() {
    EventChannel eventChannel = const EventChannel(_eventChannelName,);
    return eventChannel.receiveBroadcastStream();
  }


}
