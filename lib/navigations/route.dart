
import 'package:flutter/cupertino.dart';

import '../utils/utils.dart';

class MainRouter{

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 单例
  factory MainRouter() => _sharedInstance();

  static MainRouter? _instance;

  MainRouter._internal();

  static MainRouter _sharedInstance(){
    _instance ??= MainRouter._internal();
    return _instance!;
  }

  Map<String,WidgetBuilder> routes={};

  final RouteFactory generateRoute = (settings) {};

  void initRoute(List<Map<String,WidgetBuilder>> routeLost){
    routes.clear();
    for (var element in routeLost) {
      routes.addAll(element);
    }
    printBlue("初始化完成");
  }

  void push({String name="",Object? arguments}){
    MainRouter().navigatorKey.currentState?.pushNamed(name,arguments: arguments);
    printBlue("返回 ${arguments.toString()}");
  }

  void pop([Object? result]){
    MainRouter().navigatorKey.currentState?.pop(result);
    printBlue("返回 ${result.toString()}");
  }


}