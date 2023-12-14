import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_toolkit/ble/utils/extra.dart';
import 'package:flutter_toolkit/utils/string_utils.dart';

class BuleDetailsPage extends StatefulWidget {
  BluetoothDevice device;

  BuleDetailsPage({super.key, required this.device});

  @override
  State<BuleDetailsPage> createState() => _BuleDetailsPageState();
}

class _BuleDetailsPageState extends State<BuleDetailsPage> {
  int? _rssi;
  int? _mtuSize;
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;
  List<BluetoothService> _services = [];
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  bool _isDisconnecting = false;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;

  BluetoothCharacteristic? selectBluetoothCharacteristic;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscription = widget.device.connectionState.listen((state) async {
      _connectionState = state;
      if (state == BluetoothConnectionState.connected) {
        _services = []; // must rediscover services
      }
      if (state == BluetoothConnectionState.connected && _rssi == null) {
        _rssi = await widget.device.readRssi();
      }
      if (mounted) {
        setState(() {});
      }
    });

    _mtuSubscription = widget.device.mtu.listen((value) {
      _mtuSize = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isConnectingSubscription = widget.device.isConnecting.listen((value) {
      _isConnecting = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isDisconnectingSubscription = widget.device.isDisconnecting.listen((value) {
      _isDisconnecting = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.platformName),
        actions: [buildConnectButton(context)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  _services = await widget.device.discoverServices();
                  setState(() {});
                },
                child: Text("获取服务")),
            Column(
              children: _services.map((e) {
                return Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Text("${e.serviceUuid}"),
                      Column(
                        children: e.characteristics.map((e2) {
                          return Container(
                            child: Column(
                              children: [
                                Text("特征服务 "),
                                Text("${e2.characteristicUuid}"),
                                Text("${e2.remoteId}"),
                                ElevatedButton(
                                    onPressed: () async {
                                      var list = await e2.read();
                                      print(list);
                                      print(utf8.decode([0xe6, 0x9d, 0xa5, 0xe5, 0x95, 0xa6]));
                                    },
                                    child: Text("读取")),
                                ElevatedButton(
                                    onPressed: () {
                                      selectBluetoothCharacteristic = e2;

                                      // 字符串转 list int

                                      // StringUtils.contentToHex(content: "来啦");
                                      // StringUtils.contentToIso8859_1(content: "来啦");
                                      // StringUtils.contentToUsAscii(content: "来啦");
                                      // StringUtils.contentToUtf8(content: "来啦");

                                      // e2.write(StringUtils.contentToHex(content: "来啦"));
                                      // e2.write(StringUtils.contentToIso8859_1(content: "来啦"));
                                      // e2.write(StringUtils.contentToUsAscii(content: "来啦"));
                                      e2.write(StringUtils.contentToUtf8(content: "来啦"));
                                    },
                                    child: Text("发送")),
                                ElevatedButton(onPressed: () {}, child: Text("监听")),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildConnectButton(BuildContext context) {
    return Row(children: [
      // 在连接中或者断开连接的过程中，使用加载框
      if (_isConnecting || _isDisconnecting)
        AspectRatio(
          aspectRatio: 1.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.black12,
            color: Colors.black26,
          ),
        ),
      TextButton(
          onPressed: _isConnecting
              ? () async {
                  // 如果是已经链接，则断开
                  await widget.device.disconnect();
                }
              : (isConnected
                  ? () async {
                      // 执行断开
                      await widget.device.disconnect();
                    }
                  : () async {
                      await widget.device.connect();
                    }),
          child: Text(
            _isConnecting ? "取消" : (isConnected ? "断开" : "连接"),
            style: Theme.of(context).primaryTextTheme.labelLarge?.copyWith(color: Colors.black),
          ))
    ]);
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    _mtuSubscription.cancel();
    _isConnectingSubscription.cancel();
    _isDisconnectingSubscription.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }
}
