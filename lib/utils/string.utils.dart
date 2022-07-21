import 'dart:math';

class StringUtils {
  static String padLeft(String text, int width, String padding, [int offset = 0]) {
    var initials = text.substring(0, offset);
    return initials + text.substring(offset).padLeft(width - offset, padding);
  }

  static double hexToAmount(String hex) {
    return BigInt.parse(hex) / BigInt.from(pow(10, 18));
  }
}