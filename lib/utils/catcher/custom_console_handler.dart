import "dart:math";

import "package:flutter/material.dart";

class CustomConsoleHandler {

  @override
  void handle(Object error, StackTrace stackTrace) {
    _print("╔╣ Error");
    _print("║ Crash occurred on ${DateTime.now()}");
    _printLine();

    _print("╔ Message");
    _printChunked(error.toString().replaceAll("\n", " "));
    _printLine();

    _printStackTraceFormatted(stackTrace);
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

  void _printLine({ String pre = "╚", String suf = "╝", int maxWidth = 80 }) =>
      _print('$pre${'═' * maxWidth}$suf');

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
}
