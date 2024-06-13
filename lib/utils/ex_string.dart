part of 'utils.dart';

extension ExString on String {

  // 内容转HEX
  contentToHex() {
    List<dynamic> value = [];
    for (int i = 0; i < length; i++) {
      value.add(codeUnitAt(i).toRadixString(16));
    }
    return value;
  }

  // 转 Ascii
  contentToUsAscii() {
    List<int> asciiList = codeUnits;
    return asciiList;
  }

  // 转 Iso8859_1
  contentToIso8859_1() {
    List<int> iso8859_1List = codeUnits;
    return iso8859_1List;
  }

  // 转 utf8
  contentToUtf8() {
    List<dynamic> gbkList = codeUnits.map((codeUnit) {
      // 将UTF-8码单元转换为GBK码点
      int gbkCodePoint = codeUnit >= 0x80 ? codeUnit : codeUnit + 0xA0A0;
      // 将GBK码点转换为十六进制表示
      return gbkCodePoint.toRadixString(16).padLeft(4, '0');
    }).toList();
    return gbkList;
  }

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
