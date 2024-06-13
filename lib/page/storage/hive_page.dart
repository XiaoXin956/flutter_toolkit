import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class HivePage extends StatefulWidget {
  const HivePage({super.key});

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  String? getValue = "";

  List<Widget> _list = [
    Draggable(
        child: Container(width: 50, height: 50, child: Center(child: Text("1")), color: Colors.blue),
        feedback: Container(width: 50, height: 50, child: Center(child: Text("2")), color: Colors.blue),
        childWhenDragging: Container(width: 50, height: 50, child: Center(child: Text("3")), color: Colors.blue)),
    Draggable(
        child: Container(width: 50, height: 50, child: Center(child: Text("1")), color: Colors.red),
        feedback: Container(width: 50, height: 50, child: Center(child: Text("2")), color: Colors.red),
        childWhenDragging: Container(width: 50, height: 50, child: Center(child: Text("3")), color: Colors.red)),
    Draggable(
        child: Container(width: 50, height: 50, child: Center(child: Text("1")), color: Colors.yellow),
        feedback: Container(width: 50, height: 50, child: Center(child: Text("2")), color: Colors.yellow),
        childWhenDragging: Container(width: 50, height: 50, child: Center(child: Text("3")), color: Colors.yellow)),
    Draggable(
        child: Container(width: 50, height: 50, child: Center(child: Text("1")), color: Colors.deepPurple),
        feedback: Container(width: 50, height: 50, child: Center(child: Text("2")), color: Colors.deepPurple),
        childWhenDragging: Container(width: 50, height: 50, child: Center(child: Text("3")), color: Colors.deepPurple)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HivePage"),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                HiveUtils.saveString(key: "key", value: "${Random().nextInt(100)}");
              },
              child: Text("保存")),
          Text("$getValue"),
          TextButton(
              onPressed: () async {
                getValue = await HiveUtils.getString(key: "key", value: "");
                _list.shuffle();
                setState(() {});
              },
              child: Text("获取")),
          // Expanded(
          //     flex: 1,
          //     child: ReorderableListView(
          //       scrollDirection: Axis.horizontal,
          //       children: _list,
          //       onReorder: (int oldIndex, int newIndex) {
          //         if (oldIndex < newIndex) {
          //           newIndex -= 1;
          //         }
          //         var child = _list.removeAt(oldIndex);
          //         _list.insert(newIndex, child);
          //         setState(() {});
          //       },
          //     )),
          Expanded(
              flex: 1,
              child: Row(
                children: _list,
              )),
        ],
      ),
    );
  }
}
