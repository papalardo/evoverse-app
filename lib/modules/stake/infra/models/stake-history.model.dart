class StakeHistoryModel {
  num eKeyReward;
  num epwBonusReward;
  num hashPowerBase;
  num hashPowerBonus;
  num stakedAmount;

  StakeHistoryModel({
    required this.eKeyReward,
    required this.epwBonusReward,
    required this.hashPowerBase,
    required this.hashPowerBonus,
    required this.stakedAmount,
  });

  factory StakeHistoryModel.json(Map json) => StakeHistoryModel(
    eKeyReward: json['EKEY'],
    epwBonusReward: json['EPWBonus'],
    hashPowerBase: json['HashPowerBase'],
    hashPowerBonus: json['HashPowerBonus'],
    stakedAmount: json['StakedAmount'],
  );

}