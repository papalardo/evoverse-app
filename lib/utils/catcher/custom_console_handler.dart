import 'dart:math';

import 'package:catcher/model/platform_type.dart';
import 'package:catcher/model/report.dart';
import 'package:catcher/model/report_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomConsoleHandler extends ReportHandler {
  final bool enableDeviceParameters;
  final bool enableApplicationParameters;
  final bool enableStackTrace;
  final bool enableCustomParameters;
  final bool handleWhenRejected;

  CustomConsoleHandler({
    this.enableDeviceParameters = true,
    this.enableApplicationParameters = true,
    this.enableStackTrace = true,
    this.enableCustomParameters = false,
    this.handleWhenRejected = false,
  });

  @override
  Future<bool> handle(Report report, BuildContext? context) {
    _print("╔╣ Error");
    _print("║ Crash occurred on ${report.dateTime}");
    _printLine();

    _print("╔ Message");
    _printChunked(report.error.toString().replaceAll('\n', ' '));
    _printLine();

    if (enableDeviceParameters) {
      _printDeviceParametersFormatted(report.deviceParameters);
    }
    if (enableApplicationParameters) {
      _printApplicationParametersFormatted(report.applicationParameters);
    }
    if (enableStackTrace) {
      _printStackTraceFormatted(report.stackTrace as StackTrace?);
    }
    if (enableCustomParameters) {
      _printCustomParametersFormatted(report.customParameters);
    }
    return Future.value(true);
  }

  void _printDeviceParametersFormatted(Map<String, dynamic> deviceParameters) {
    _print("╔ Device Info");
    for (final entry in deviceParameters.entries) {
      _print("║ ${entry.key}: ${entry.value}");
    }
    _printLine();
  }

  _chunkString(String msg) {
    var chunks = [];
    int chunkSize = 120;
    for (var i = 0; i < msg.length; i += chunkSize) {
      chunks.add(msg.substring(i, min(msg.length, i + chunkSize)));
    }
    return chunks;
  }

  _print(String msg) => debugPrint(msg);

  _printChunked(String msg) {
    for (final str in _chunkString(msg)) {
      _print("║ $str");
    }
  }

  void _printLine({ String pre = '╚', String suf = '╝', int maxWidth = 80 }) =>
      _print('$pre${'═' * maxWidth}$suf');


  void _printApplicationParametersFormatted(
    Map<String, dynamic> applicationParameters,
  ) {
    _print("╔ App Info");
    for (final entry in applicationParameters.entries) {
      _print("║ ${entry.key}: ${entry.value}");
    }
    _printLine();
  }

  void _printCustomParametersFormatted(Map<String, dynamic> customParameters) {
    _print("╔ Custom Info");
    for (final entry in customParameters.entries) {
      _print("║ ${entry.key}: ${entry.value}");
    }
    _printLine();
  }

  void _printStackTraceFormatted(StackTrace? stackTrace) {
    _print("╔ Stack trace");
    int maxWidth = 80;
    var traceLines = stackTrace.toString().split("\n");
    for (final entry in traceLines.sublist(0, min(traceLines.length, 12))) {
      _print("║ $entry");
      if (entry.length > maxWidth) {
        maxWidth = entry.length;
      }
    }
    _printLine(maxWidth: maxWidth);
  }

  @override
  List<PlatformType> getSupportedPlatforms() => [
    PlatformType.android,
    PlatformType.iOS,
    PlatformType.web,
    PlatformType.linux,
    PlatformType.macOS,
    PlatformType.windows,
  ];

  @override
  bool shouldHandleWhenRejected() {
    return handleWhenRejected;
  }
}
