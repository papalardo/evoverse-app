class TrainingHistoryModel {
  String evo;
  int trainingId;
  String trainingType;
  num bidAmount;
  num rewardAmount;
  DateTime? date;

  TrainingHistoryModel({
    required this.evo,
    required this.bidAmount,
    required this.trainingId,
    required this.date,
    required this.trainingType,
    required this.rewardAmount,
  });

  factory TrainingHistoryModel.fromJson(Map json) => TrainingHistoryModel(
      evo: json["evo"],
      trainingId: json['fk_training_id'],
      trainingType: json['training_type'],
      date: DateTime.tryParse(json['end_date']),
      bidAmount: json["recharge_amount"],
      rewardAmount: json["reward_amount"],
  );

}