import 'package:get/get_state_manager/src/simple/list_notifier.dart';

mixin LoaderStateMixin implements ListNotifierMixin {
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

    refresh();
  }

  bool isLoading([String key = 'default']) => loaders[key] ?? false;

  bool anyLoading() => loaders.values.every((status) => status == true);
}