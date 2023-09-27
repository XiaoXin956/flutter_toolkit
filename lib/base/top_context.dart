import 'package:flutter/material.dart';


class TopContext{

  static BuildContext? topContext;

  static void setContext(BuildContext context){
    topContext = context;
  }

  static BuildContext? getTopContext() {
    return topContext;
  }

}
