import "package:app/core/app.bindings.dart";
import "package:app/core/config/error-handler-config.dart";
import "package:catcher/catcher.dart";
import "package:flutter/material.dart";

class Bootstrap {
  _boot() async {
    await AppBindings.initServices();
  }

  init(Widget app) async {
    FutureBuilder.debugRethrowError = true;

    Catcher(
      runAppFunction: () async {
        await _boot();
        runApp(app);
      },
      debugConfig: ErrorHandlerConfig.debug(),
      releaseConfig: ErrorHandlerConfig.release(),
      ensureInitialized: true,
    );
  }

}

