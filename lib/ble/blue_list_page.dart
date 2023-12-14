import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_toolkit/ble/blue_details_page.dart';

class BlueListPage extends StatefulWidget {
  const BlueListPage({super.key});

  @override
  State<BlueListPage> createState() => _BlueListPageState();
}

class _BlueListPageState extends State<BlueListPage> {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription; //
  late StreamSubscription<bool> _isScanningSubscription; // 扫描

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });

    FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      setState(() {});
    }, onError: (e) {
      print("${e}");
    });

    FlutterBluePlus.isScanning.listen((state) {
      setState(() {
        _isScanning = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = _adapterState == BluetoothAdapterState.on ? showBlueList() : blueOffState();
    return Scaffold(
      appBar: AppBar(
        title: Text("蓝牙列表"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: screen),
            ElevatedButton(
                onPressed: () async {
                  try {
                    _systemDevices = await FlutterBluePlus.systemDevices;
                  } catch (error) {
                    print("设备信息异常");
                  }
                  int divisor = Platform.isAndroid ? 8 : 1;
                  await FlutterBluePlus.startScan(timeout: Duration(seconds: 10), continuousUpdates: true, continuousDivisor: divisor);
                  await FlutterBluePlus.startScan();
                },
                child: Text("扫描")),
            ElevatedButton(
                onPressed: () async {
                  FlutterBluePlus.stopScan();
                },
                child: Text("停止")),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Widget blueOffState() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  try {
                    await FlutterBluePlus.turnOn();
                  } catch (error) {
                    print("被拒绝了");
                  }
                }
              },
              child: Text("打开蓝牙")),
        ],
      ),
    );
  }

  // 显示列表
  Widget showBlueList() {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: _scanResults.length,
      itemBuilder: (BuildContext context, int index) {
        ScanResult scanResult = _scanResults[index];
        return Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 1))),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Text("name： ${scanResult.device.name}"),
                  Text("localName： ${scanResult.device.localName}"),
                  Text("isConnected： ${scanResult.device.isConnected}"),
                  Text("mtuNow： ${scanResult.device.mtuNow}"),
                  Text("advName： ${scanResult.device.advName}"),
                  Text("platformName： ${scanResult.device.platformName}"),
                ],
              )),
              ElevatedButton(onPressed: () {
                if(scanResult.device.isConnected){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return BuleDetailsPage(device: scanResult.device,);
                  }));
                }else{
                  scanResult.device.connect(timeout: Duration(seconds: 20));
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return BuleDetailsPage(device: scanResult.device,);
                  }));
                }
              }, child: Text(scanResult.device.isConnected? "进入":"连接")),
            ],
          ),
        );
      },
    );
  }
}
