part of 'utils.dart';

class CurrencyUtils {

  static String formatCurrency(double value) {
    return value.toStringAsFixed(2);
  }

  static String formatCurrencyWithComma(dynamic money) {

    var formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(money.truncate());
  }


}

