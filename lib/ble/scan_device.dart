import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_toolkit/utils/print_utils.dart';


typedef OnFind = void Function(DeviceBean device);
typedef OnStop = void Function();
class ScanCallback {
  ScanCallback ({required this.onFind, required this.onStop});
  OnFind onFind;
  OnStop onStop;
}

class ScanDevice {
  static const int SCAN_TIMEOUT = 10000;
  final String NAME_PREFIX = "T";
  final String NAME_PREFIX_2 = "HLW";
  final FlutterBluePlus _flutterBlue = FlutterBluePlus(); //蓝牙API
  final ScanCallback _callback; //回调接口
  var _isScanning = false;
  late Timer? _timer = null;
  ScanDevice(this._callback);
  //开始扫描
  void startScan({int timeout = SCAN_TIMEOUT}) {
    printBlue("1.开始扫描设备 >>>>>>");
    if (_isScanning) return;
    _isScanning = true;
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult item in results) {
        _handlerScanResult(item);
      }
    });
    FlutterBluePlus.startScan(timeout: Duration(seconds: timeout));
    startTimer();
  }
  //N秒后停止扫描, 并回调通知外部
  void startTimer(){
    cancelTimer();
    _timer = Timer(Duration(milliseconds: SCAN_TIMEOUT), () {
      stopScan(); //停止扫描
      _callback.onStop(); //回调通知外部
    });
  }
  void cancelTimer(){
    _timer?.cancel();
    _timer = null;
  }
  //是否扫描中
  bool isScan() {
    return _isScanning;
  }
  //停止扫描
  void stopScan() {
    printBlue("停止扫描设备 >>>>>>");
    cancelTimer();
    if (!_isScanning) return;
    _isScanning = false;
    FlutterBluePlus.stopScan();
  }
  //处理扫描结果
  void _handlerScanResult(ScanResult result) {
    if (!result.device.name.startsWith(NAME_PREFIX) && !result.device.name.startsWith(NAME_PREFIX_2)) return; //过滤掉非本公司的蓝牙设备
    printBlue('扫到设备, name: ${result.device.name}');
    if (result.device.name.startsWith(NAME_PREFIX_2)) { //针对定制过的蓝牙设备，需要从广播中获取真正的设备名称
      var realName = result;  //从广播中获取真实的设备名称

      _callback.onFind(DeviceBean(result.device)); //回调到外部
      return;
    }
    _callback.onFind(DeviceBean(result.device)); //回调到外部
  }
}



class DeviceBean {
  BluetoothDevice device; //设备
  DeviceBean(this.device);
}