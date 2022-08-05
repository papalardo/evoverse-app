import 'package:app/modules/config/infra/models/config-list.model.dart';
import 'package:app/modules/config/infra/models/config.model.dart';
import 'package:app/modules/config/utils/config-keys.dart';

class BoostPodConfigModel {
  int epicBootCost;
  int legendaryBoostCost;
  Duration boostDuration;

  BoostPodConfigModel({
    required this.epicBootCost,
    required this.legendaryBoostCost,
    required this.boostDuration,
  });

  factory BoostPodConfigModel.fromList(List configList) {
    var configs = ConfigListModel.fromList(configList);
    return BoostPodConfigModel(
      epicBootCost: configs
          .value<int>(ConfigKeys.boostEpicCost) ?? 0,
      legendaryBoostCost: configs
          .value<int>(ConfigKeys.boostLegendaryCost) ?? 0,
      boostDuration: Duration(
        seconds: configs.value<int>(ConfigKeys.boostDuration) ?? 0
      )
    );
  }

}