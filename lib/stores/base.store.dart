import 'package:app/utils/widgets/loader/loader-state.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseStore<T extends GetxController> extends GetxController
    with LoaderStateMixin {

  dynamic _error;

  Future<void> fetch();

  reload() async {
    try {
      setLoading(true);
      await fetch();
      _error = null;
    } catch (e) {
      _error = e;
    } finally {
      setLoading(false);
    }
    update();
  }

  dynamic getError() => _error;

  Widget when({
    required Widget Function() done,
    Widget Function()? busy,
    Widget Function(dynamic)? error,
  }) {
    return GetBuilder<T>(
        builder: (controller) {
          // BUSY
          if (isLoading()) {
            return busy == null ? const SizedBox() : busy();
          }
          // ERROR
          var _error = getError();
          if (_error != null) {
            return error == null ? const Text("Error") : error(_error);
          }
          // DONE
          return done();
        }
    );
  }

}