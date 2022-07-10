import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
      errorMethodCount: 8,
      colors: true,
      printEmojis: true,
      printTime: true
  ),
);