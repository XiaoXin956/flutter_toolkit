
import 'package:flutter/foundation.dart';

class CountProvider with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }



}