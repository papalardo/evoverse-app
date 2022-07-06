import 'package:intl/intl.dart';

class Number {
  static String toCurrency(dynamic price) {
    var usCurrency = NumberFormat('#,##0.00', 'en_US');
    return usCurrency.format(price);
  }
}