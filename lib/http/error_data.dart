import 'dart:io';

import 'package:dio/dio.dart';

import '../utils/print_utils.dart';

class ErrorData {
  static dynamic analysisError(dynamic error) {

    dynamic errorData = {};
    if(error is DioException){
      var statusCode = error.response?.statusCode;
      if (statusCode == 400) {
        String msg = "賬號或密碼錯誤！";
        errorData =  {"code": 400, "success": false, "msg": msg};
      } else if (statusCode == 401) {
        String msg = "您的賬號在另壹臺設備上登錄，請重新登錄！";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 403) {
        String msg = "您的賬號在另壹臺設備上登錄，請重新登錄！";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 404) {
        String msg = "數據異常，請聯繫管理員";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 1001) {
        String msg = "網絡異常，請稍後再試";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 1002) {
        String msg = "網絡異常，請稍後再試";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 1003) {
        String msg = "數據不存在，請聯繫管理員";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 2001) {
        String msg = "訂單不存在";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 2002) {
        String msg = "該訂單已處理";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 406) {
        String msg = "您的賬號已過期，請聯繫CXC客服處理";
        errorData =  {"code": 401, "success": false, "msg": msg};
      } else if (statusCode == 406) {
        String msg = "數據異常，請聯繫管理員";
        errorData =  {"code": 401, "success": false, "msg": msg};
      }
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
