class PodModel {
  int id;
  int stars;
  bool upgraded;
  double hashPower;
  double totalHashPower;
  bool boosted;
  bool farming;
  String rarity;

  PodModel({
    required this.id,
    required this.stars,
    required this.upgraded,
    required this.hashPower,
    required this.farming,
    required this.totalHashPower,
    required this.boosted,
    required this.rarity,
  });

  static fromJson(Map json) => PodModel(
    id: json['NFTId'],
    stars: json['Stars'],
    farming: json['Energizing'],
    upgraded: json['Upgraded'],
    hashPower: json['HashPower'],
    totalHashPower: json['CalculatedHashPower'],
    boosted: json['Boosted'],
    rarity: json['Rarity']
  );
}