class StakePreviewModel {
  num newDailyEkey;
  num newHashPowerBonus;
  num newStakeTotal;
  num newTotalHashPower;

  StakePreviewModel({
    required this.newDailyEkey,
    required this.newHashPowerBonus,
    required this.newStakeTotal,
    required this.newTotalHashPower,
  });

  factory StakePreviewModel.fromJson(Map json) => StakePreviewModel(
    newDailyEkey: json["new_daily_ekey"],
    newHashPowerBonus: json["new_hash_power_bonus"],
    newStakeTotal: json["new_stake_total"],
    newTotalHashPower: json["new_total_hash_power"],
  );

}