import 'package:another_flushbar/flushbar.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Toast {

  static show(String message, [String? title]) => Flushbar(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    backgroundColor: const Color(0xFF325071),
    borderRadius: BorderRadius.circular(5),
    duration: const Duration(seconds: 5),
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    title: title,
  )..show(Get.context!);

  static danger(String message, [String? title]) => Flushbar(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    backgroundColor: AppPalette.DANGER,
    borderRadius: BorderRadius.circular(5),
    duration: const Duration(seconds: 5),
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    title: title,
  )..show(Get.context!);

}