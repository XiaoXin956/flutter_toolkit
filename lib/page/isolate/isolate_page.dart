import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolatePage extends StatefulWidget {
  const IsolatePage({super.key});

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  dynamic result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IsolatePage")),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  computeData();
                },
                child: Text("jisuanqi"))
          ],
        ),
      ),
    );
  }

  // isolate计算数据
  // 1. 创建Isolate对象
  // 2. 发送消息给Isolate，Isolate执行任务
  // 3. Isolate执行完任务后，发送消息给UI线程，UI线程更新UI
  // 4. 关闭Isolate
  Future<void> computeData() async {
    // 接收端口
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn((sendPort) async {
      await Future.delayed(Duration(seconds: 2));
      sendPort.send(100);
    }, receivePort.sendPort);

    receivePort.listen((data) {
      print(data);
      receivePort.close();
    },
    onDone: () {
      print("Isolate执行完毕");
    }
    );
  }
}
