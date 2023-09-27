

import 'package:flutter/material.dart';
import 'package:flutter_toolkit/base/top_context.dart';
import 'package:flutter_toolkit/utils/print_utils.dart';

showSnackBar({String msg=""}){

  if(TopContext.getTopContext()!=null){
    ScaffoldMessenger.of(TopContext.getTopContext()!).showSnackBar(SnackBar(content: Text(msg)));
  }else{
    printRed("context 未初始化");
  }

}