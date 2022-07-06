import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AppPlatform {
  static final isIOS      = Platform.isIOS;
  static final isAndroid  = Platform.isAndroid;
  static final isFuchsia  = Platform.isFuchsia;
  static final isLinux    = Platform.isLinux;
  static final isMacOS    = Platform.isMacOS;
  static final isWindows  = Platform.isWindows;
  static const isWeb      = kIsWeb;
  static final isDesktop  = Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  static final isMobile   = Platform.isIOS || Platform.isAndroid || Platform.isFuchsia;
  static final systemName = Platform.operatingSystem;
}