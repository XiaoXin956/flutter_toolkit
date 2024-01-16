import 'dart:convert';


class StringUtils {

  // 内容转HEX
 static contentToHex({String content = ""}) {
   List<dynamic> value = [];
   for (int i = 0; i < content.length; i++){
     value.add(content.codeUnitAt(i).toRadixString(16));
   }
    return value;
  }

  // 转 Ascii
 static contentToUsAscii({String content = ""}){
    List<int> asciiList = content.codeUnits;
    return asciiList;
  }


  // 转 Iso8859_1
 static contentToIso8859_1({String content = ""}){
    List<int> iso8859_1List = content.codeUnits;
    return iso8859_1List;
  }


 static contentToUtf8({String content = ""}){
    List<dynamic> gbkList = content.codeUnits.map((codeUnit) {
      // 将UTF-8码单元转换为GBK码点
      int gbkCodePoint = codeUnit >= 0x80 ? codeUnit : codeUnit + 0xA0A0;
      // 将GBK码点转换为十六进制表示
      return gbkCodePoint.toRadixString(16).padLeft(4, '0');
    }).toList();
    return gbkList;
  }



}
