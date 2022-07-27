import "package:app/modules/config/infra/models/config.model.dart";
import "package:app/modules/training/infra/models/training-history.model.dart";

class TrainingDataModel {
  List rechargedEvos;
  List<TrainingHistoryModel> history;
  List<ConfigModel> config;
  DateTime startDate;
  num epwSpent;

  TrainingDataModel({
    required this.rechargedEvos,
    required this.history,
    required this.config,
    required this.startDate,
    required this.epwSpent,
  });

  factory TrainingDataModel.fromJson(Map json) => TrainingDataModel(
    rechargedEvos: [],
    startDate: DateTime.now(),
    history: List.from(json["history"].map((e) => TrainingHistoryModel.fromJson(e))),
    config: List.from(json["training_config"].map((e) => ConfigModel.fromJson(e))),
    epwSpent: json["epwSpent"],
  );
}