import 'package:app/utils/widgets/loader/loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderController extends GetxController {
  var loading = false.obs;

  Future<T> showWhile<T>(Future<T> Function() asyncFunction) {
    return Get.showOverlay<T>(
      asyncFunction: asyncFunction,
      loadingWidget: const LoaderWidget()
    );
  }

  void show() => loading(true);

  void hide() => loading(false);
}