import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_toolkit/utils/hive_utils.dart';

class HivePage extends StatefulWidget {
  const HivePage({super.key});

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {

  String? getValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HivePage"),
      ),
      body: Column(
        children: [
          
          TextButton(onPressed: (){

            HiveUtils.saveString( key:"key",value: "${Random().nextInt(100)}");
          }, child: Text("保存")),

          Text("$getValue"),
          TextButton(onPressed: () async {
            getValue = await HiveUtils.getString(key: "key", value: "");
            setState(() {
            });
          }, child: Text("获取")),

        ],
      ),
    );
  }
}
