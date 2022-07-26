import 'package:app/utils/logger.dart';
import 'package:app/utils/widgets/loader/loader-state.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseStore<P extends GetxController, M> extends GetxController
    with LoaderStateMixin {

  M? _state;

  M? get state => _state;

  dynamic _error;

  Future<M> fetch();

  @override
  onInit() {
    reload();
    super.onInit();
  }

  Future<void> reload() async {
    try {
      setLoading(true);
      _state = await fetch();
      _error = null;
    } catch (e, s) {
      _error = e;
      logger.d(null, e, s);
    } finally {
      setLoading(false);
    }
    update();
  }

  dynamic getError() => _error;

  Widget when({
    required Widget Function(M) done,
    Widget Function()? busy,
    Widget Function(dynamic)? error,
    Widget? empty,
  }) {
    return GetBuilder<P>(
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
          // EMPTY
          if (_state == null) {
            return empty ?? const SizedBox();
          }
          // DONE
          return done(_state!);
        }
    );
  }

}