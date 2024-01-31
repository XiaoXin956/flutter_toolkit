import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_toolkit/page/channel/android_native/android_native.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  String responseSyncValue = "";
  String responseAsyncValue = "";
  String basicAsyncResponseValue = "";
  String basicSyncResponseValue = "";
  String eventResponseValue = "";

  StreamSubscription<dynamic>? eventChannelSubscription;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 调用原生
          Text("${responseSyncValue}"),
          TextButton(
              onPressed: () async {
                // 同步调用原生
                AndroidNative.callSyncMethodChannel("flutter 发送的数据").then((value) {
                  setState(() {
                    responseSyncValue = value.toString();
                  });
                });
              },
              child: Text("Method Channel 同步调用原生")),
          // 异步调用原生
          Text("${responseAsyncValue}"),
          TextButton(
              onPressed: () async {
                // 异步调用原生
                AndroidNative.callAsyncMethodChannel("flutter 发送的数据", resultFun: (value) {
                  setState(() {
                    responseAsyncValue = value.toString();
                  });
                });
              },
              child: Text("Method Channel 异步调用原生")),

          Text("basic 异步"),
          Text("basic : ${basicAsyncResponseValue}"),
          TextButton(
              onPressed: () async {
                AndroidNative.callAsyncBasicMessageChannel(message: "basic数据", result: (value) {
                  setState(() {
                    basicAsyncResponseValue = value.toString();
                  });
                });
              },
              child: Text("Basic Message Channel 调用原生")),

          Text("basic 同步"),
          Text("basic : ${basicSyncResponseValue}"),
          TextButton(onPressed: () async {
            dynamic result = await AndroidNative.callSyncBasicMessageChannel(message: "basic数据");
            setState(() {
              basicSyncResponseValue = result.toString();
            });
          }, child: Text("Basic Message Channel 同步 调用原生")),


          Text("event channel 数据  $eventResponseValue"),
          TextButton(onPressed: () async {
            if(eventChannelSubscription!=null){
              return;
            }
            eventChannelSubscription = AndroidNative.callEventChannel().listen((event) {
              setState(() {
                eventResponseValue = event.toString();
              });
            });

          }, child: Text("Event channel 发起订阅")),

          TextButton(onPressed: () async {
            eventChannelSubscription?.cancel();
            eventChannelSubscription = null;
          }, child: Text("Event channel 取消订阅")),

        ],
      ),
    );
  }

  @override
  void dispose() {

    eventChannelSubscription?.cancel();
    eventChannelSubscription = null;

    super.dispose();
  }

}
