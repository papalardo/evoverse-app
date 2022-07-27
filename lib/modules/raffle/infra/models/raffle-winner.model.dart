import "package:app/modules/raffle/infra/models/raffle-winner-reward.model.dart";

class RaffleWinnerModel {
  int position;
  int playerId;
  String playerName;
  List<RaffleWinnerRewardModel> rewards;

  RaffleWinnerModel({
    required this.position,
    required this.playerId,
    required this.playerName,
    required this.rewards,
  });

  factory RaffleWinnerModel.fromJson(Map json) => RaffleWinnerModel(
    position: json["raffle_position"],
    playerId: json["id"],
    playerName: json["display_name"],
    rewards: List.from(json["rewards"].map((e) => RaffleWinnerRewardModel.fromJson(e))),
  );
}