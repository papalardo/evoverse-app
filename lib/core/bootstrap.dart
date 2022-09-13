import 'dart:async';
import 'dart:io';

import "package:app/core/app.bindings.dart";
import 'package:app/utils/catcher/custom_console_handler.dart';
import 'package:app/utils/logger.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";

import "package:app/firebase_options.dart";

class Bootstrap {
  _boot() async {
    WidgetsFlutterBinding.ensureInitialized();
    FutureBuilder.debugRethrowError = true;

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    } catch (err) {
      //
    }

    await AppBindings.initServices();
  }

  init(Widget app) async {
    runZonedGuarded<Future<void>>(
      () async {
        await _boot();
        runApp(app);
      },
      handleExceptions,
    );
  }

  void handleExceptions(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      CustomConsoleHandler().handle(error, stackTrace);
      return;
    }

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      printDetails: false,
      fatal: true,
    );
  }
}
