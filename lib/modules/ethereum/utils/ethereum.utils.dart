import 'package:app/utils/string.utils.dart';

class EthereumUtils {
  static String addressToTopic(String hex) {
    return StringUtils.padLeft(hex, 66, '0', 2);
  }
}