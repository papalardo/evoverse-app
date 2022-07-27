import 'package:app/modules/config/infra/models/config-list.model.dart';
import "package:app/modules/config/infra/models/config.model.dart";
import 'package:app/modules/config/utils/config-keys.dart';
import "package:app/modules/training/infra/models/training-history.model.dart";
import 'package:app/modules/training/infra/models/training.model.dart';

import 'package:app/modules/training/infra/models/training-bid.model.dart';

class TrainingDataModel {
  List<TrainingBidModel> playerBids;
  List<TrainingHistoryModel> history;
  List<ConfigModel> config;
  List<TrainingModel> trainings;
  DateTime startDate;
  num epwSpent;
  num bidCost;
  String bidCurrency;
  int duration;

  TrainingDataModel({
    required this.playerBids,
    required this.history,
    required this.trainings,
    required this.config,
    required this.startDate,
    required this.epwSpent,
    required this.bidCost,
    required this.bidCurrency,
    required this.duration,
  });

  factory TrainingDataModel.fromJson(Map json) {
    var config = ConfigListModel.fromList(json["training_config"]);

    return TrainingDataModel(
      playerBids: List.from(
        json['recharged_evos'].map((e) => TrainingBidModel.fromJson(e))
      ),
      startDate: DateTime.now(),
      trainings: List.from(
        json["open_trainings"].map((e) => TrainingModel.fromJson(e))
      ),
      history: List.from(
        json["history"].map((e) => TrainingHistoryModel.fromJson(e)),
      ),
      bidCost: config.value<num>(ConfigKeys.trainingRechargeCost, 0)!,
      bidCurrency: config.value(ConfigKeys.trainingRechargeCurrency),
      duration: config.value<int>(ConfigKeys.trainingTimeRemaining, 0)!,
      config: List.from(
        json["training_config"].map((e) => ConfigModel.fromJson(e)),
      ),
      epwSpent: json["epw_spent"],
    );
  }

}
