import 'package:app/app.dart';
import 'package:app/core/app.bindings.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await AppBindings.initServices();

  runApp(const App());
}

