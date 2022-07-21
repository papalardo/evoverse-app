class TrainingHistoryModel {
  String evo;
  num bidAmount;
  num rewardAmount;

  TrainingHistoryModel({
    required this.evo,
    required this.bidAmount,
    required this.rewardAmount,
  });

  factory TrainingHistoryModel.fromJson(Map json) => TrainingHistoryModel(
      evo: json['evo'],
      bidAmount: json['recharge_amount'],
      rewardAmount: json['reward_amount'],
  );

}