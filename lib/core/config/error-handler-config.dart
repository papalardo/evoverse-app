import 'package:app/utils/catcher/custom_console_handler.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';

class ErrorHandlerConfig {
  static CatcherOptions debug() => CatcherOptions(
    SilentReportMode(),
    [
      CustomConsoleHandler(
        enableDeviceParameters: false,
        enableApplicationParameters: false,
      ),
      ToastHandler(
        gravity: ToastHandlerGravity.top,
        backgroundColor: Colors.red.withOpacity(0.6)
      ),
    ],
  );

  static CatcherOptions release() => CatcherOptions(
    SilentReportMode(),
    [
      DiscordHandler(
        "https://discord.com/api/webhooks/995298333008601139/rgJ47Oa8gfQ4Lc8eD_yoQjKy2LMTYftmOfJSyK-uYw4sqMihli9KnMSDXUz_pc7A9TKS",
        enableDeviceParameters: true,
        enableApplicationParameters: true,
        enableCustomParameters: true,
        enableStackTrace: true,
        printLogs: true,
      ),
    ]
  );
}