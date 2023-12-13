import 'package:flutter/material.dart';

/// 用于提供全局的 navigatorContext
class NavigatorProvider {
  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
}
