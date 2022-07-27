class PlayerItemPodModel {
  int id;
  String rarity;
  int stars;
  num hashPower;
  num hashPowerTotal;
  bool boosted;
  int boostEnds;
  bool mining;
  bool onSale;
  bool onSalePending;

  PlayerItemPodModel({
    required this.id,
    required this.rarity,
    required this.stars,
    required this.hashPower,
    required this.hashPowerTotal,
    required this.boosted,
    required this.boostEnds,
    required this.mining,
    required this.onSale,
    required this.onSalePending,
  });

  factory PlayerItemPodModel.fromJson(Map json) => PlayerItemPodModel(
    id: json["NFTId"],
    rarity: json["Rarity"],
    stars: json["Stars"],
    hashPower: json["HashPower"],
    hashPowerTotal: json["CalculatedHashPower"],
    boosted: json["Boosted"],
    boostEnds: json["BoostTimer"] ?? 0,
    mining: json["Energizing"] ?? false,
    onSale: json["OnSale"] ?? false,
    onSalePending: json["SalePending"] ?? false,
  );

  bool canBoost() => [
    mining,
    onSalePending,
    onSale,
    mining,
    boosted
  ].contains(true) == false;

}