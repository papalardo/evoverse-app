class PlayerHashPowerModel {
  num bonus;
  num hpBase;
  num hpTotal;

  PlayerHashPowerModel({
    required this.bonus,
    required this.hpBase,
    required this.hpTotal,
  });

  factory PlayerHashPowerModel.fromJson(Map json) => PlayerHashPowerModel(
    bonus: json['hash_power_bonus'],
    hpBase: json['player_hash_power_base'],
    hpTotal: json['player_total_hash_power'],
  );

}