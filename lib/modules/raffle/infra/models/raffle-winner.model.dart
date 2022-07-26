import 'raffle-winner-reward.model.dart';

class RaffleWinnerModel {
  int position;
  String playerName;
  List<RaffleWinnerRewardModel> rewards;

  RaffleWinnerModel({
    required this.position,
    required this.playerName,
    required this.rewards,
  });

  factory RaffleWinnerModel.fromJson(Map json) => RaffleWinnerModel(
    position: json['raffle_position'],
    playerName: json['display_name'],
    rewards: List.from(json['rewards'].map((e) => RaffleWinnerRewardModel.fromJson(e))),
  );
}