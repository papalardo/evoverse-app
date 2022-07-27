class TrainingBidModel {
  String evo;
  String trainingType;
  int amount;

  TrainingBidModel({
    required this.evo,
    required this.trainingType,
    required this.amount,
  });

  factory TrainingBidModel.fromJson(Map json) {
    return TrainingBidModel(
        evo: json['evo'],
        trainingType: json['training_type'],
        amount: json['total_amount'],
    );
  }
}