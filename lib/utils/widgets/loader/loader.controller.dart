import 'package:app/utils/widgets/loader/loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderController extends GetxController {
  Map<String, bool> loaders = {
    'default': false,
  };

  Future<void> wait(Future Function() callable, [String key = 'default']) async {
    setLoading(true, key);
    try {
      await callable();
    } finally {
      setLoading(false, key);
    }
  }

  void setLoading(bool newStatus, [String key = 'default']) {
    if (newStatus == true) {
      loaders[key] = newStatus;
    } else {
      loaders.remove(key);
    }

    update();
  }

  bool isLoading([String key = 'default']) => loaders[key] ?? false;

  bool anyLoading() => loaders.values.every((status) => status == true);
}