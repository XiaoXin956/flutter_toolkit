import 'dart:io';

import 'package:dio/dio.dart';

import '../utils/utils.dart';

class ErrorData {
  static dynamic analysisError(dynamic error) {

    dynamic errorData = {};
    if(error is DioException){
      var statusCode = error.response?.statusCode;

    }else if(error is HttpException){
      String msg = "網絡連接超時，請稍後再試";
      errorData =  {"code": 1, "success": false, "msg": msg};
      printRed("异常 SocketException ${error}");
    }else if(error is SocketException){
      String msg = "網絡連接超時，請稍後再試";
      errorData =  {"code": 1, "success": false, "msg": msg};
      printRed("异常 SocketException ${error}");
    }
    printRed("异常 ${errorData}");
    return errorData;
  }
}
