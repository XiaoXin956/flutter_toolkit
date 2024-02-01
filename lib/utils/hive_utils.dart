
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';



class HiveUtils{

  static Box<String>? _box;

  static initHive() async {
    await Hive.initFlutter();
    _box ??= await Hive.openBox<String>('stringBox');
  }

  static Future<void> saveString({required String key,required String value}) async {
    _printRed("存储的数据：key=$key,value=$value");
    await _box?.put(key, value);
  }

  static Future<String?> getString({required String key, required String value}) async {
    _printRed("取出的数据：key=$key,value=$value");
    return _box?.get(key, defaultValue: value);
  }

  static Future<bool?> checkExistence({required String key}) async {
    _printRed("检查的数据key：key=$key");
    return _box?.containsKey(key);
  }

  static Future<void> delKey({required String key}) async {
    _printRed("删除的key：key=$key");
    return _box?.delete(key);
  }

  static _printRed(dynamic msg){
    if (kDebugMode) {
      print("\x1B[31m ${msg} \x1B[0m");
    }
  }

}