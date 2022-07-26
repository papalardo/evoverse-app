import 'package:app/utils/logger.dart';
import 'package:get/get.dart';

import 'config.model.dart';

class ConfigListModel {
  List<ConfigModel> configs = [];

  ConfigListModel({
    required this.configs,
  });

  factory ConfigListModel.fromList(List list) {
    return ConfigListModel(
      configs: List.from(list.map((e) => ConfigModel.fromJson(e))),
    );
  }

  T? value<T>(String key, [T? defaultValue]) {
    var config = configs.firstWhereOrNull((config) => config.field == key);

    if (config == null) {
      return defaultValue;
    }

    if (null is T) {
      return config.value as T;
    }

    if (T == int) {
      return int.tryParse(config.value) as T;
    }

    return config.value as T;
  }

}