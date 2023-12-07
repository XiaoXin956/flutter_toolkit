

import 'package:flutter/foundation.dart';

printRed(dynamic msg){
  if (kDebugMode) {
    print("\x1B[31m ${msg} \x1B[0m");
  }
}
printBlue(dynamic msg){
  if (kDebugMode) {
    print("\x1B[34m ${msg} \x1B[0m");
  }
}
printWhite(dynamic msg){
  if (kDebugMode) {
    print("\x1B[37m ${msg} \x1B[0m");
  }
}
printPurple(dynamic msg){
  if (kDebugMode) {
    print("\x1B[35m ${msg} \x1B[0m");
  }
}