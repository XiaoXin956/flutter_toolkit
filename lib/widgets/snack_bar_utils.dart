import 'package:flutter/material.dart';
import 'package:flutter_toolkit/base/top_context.dart';
import 'package:flutter_toolkit/utils/print_utils.dart';

showSnackBar({String msg = ""}) {
  assert(NavigatorProvider.navigatorKey.currentContext != null, "NavigatorProvider.navigatorKey 未初始化");
  ScaffoldMessenger.of(NavigatorProvider.navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(msg)));
}
