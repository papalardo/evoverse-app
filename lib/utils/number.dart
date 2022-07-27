import "package:intl/intl.dart";

class Number {
  static String toCurrency(dynamic price, [int decimalSize = 2]) {
    var usCurrency = NumberFormat("#,##0.${'0' * decimalSize}", "en_US");
    return usCurrency.format(price);
  }
}