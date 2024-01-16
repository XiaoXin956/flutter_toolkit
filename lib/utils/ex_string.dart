extension ExString on String{

  // 解析 path url
  Map<String,dynamic> urlAnalyze(){
    Map<String, dynamic> paramMap = {};
    split('&').forEach((element) {
      var kv = element.split('=');
      paramMap[kv[0]] = kv[1];
    });
    return paramMap;
  }

}