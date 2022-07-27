import "package:app/modules/stake/infra/models/stake-history.model.dart";

class StakeModel {
  num eKeyDaily;
  num eKeyToClaim;
  num hashPowerBonus;
  num nextHashPowerBonus;
  num nextEpwRange;
  num userHashPower;
  num userHashPowerBase;
  num userTotalStaked;
  List<StakeHistoryModel> stakeHistory;

  StakeModel({
    required this.eKeyDaily,
    required this.eKeyToClaim,
    required this.hashPowerBonus,
    required this.nextHashPowerBonus,
    required this.nextEpwRange,
    required this.userHashPower,
    required this.userHashPowerBase,
    required this.userTotalStaked,
    required this.stakeHistory,
  });

  factory StakeModel.fromJson(Map json) => StakeModel(
    eKeyDaily: json["daily_ekey"],
    eKeyToClaim: json["ekey_to_claim"],
    hashPowerBonus: json["hash_power_bonus"],
    nextHashPowerBonus: json["next_hp_bonus"],
    nextEpwRange: json["epw_next_range"],
    userHashPower: json["player_hash_power"],
    userHashPowerBase: json["player_hash_power_base"],
    userTotalStaked: json["stake_total"],
    stakeHistory: List.from(json["staking_history"].map((e) => StakeHistoryModel.json(e))),
  );

}