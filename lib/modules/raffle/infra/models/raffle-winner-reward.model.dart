class RaffleWinnerRewardModel {
  String amount;
  String name;

  RaffleWinnerRewardModel({
    required this.amount,
    required this.name,
  });

  factory RaffleWinnerRewardModel.fromJson(Map json) => RaffleWinnerRewardModel(
    amount: json['amount'],
    name: json['reward_name'],
  );
}