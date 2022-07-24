class MintPodModel {
  int podId;
  String rarity;
  num hashPower;
  bool isGenesis;

  MintPodModel({
    required this.podId,
    required this.rarity,
    required this.hashPower,
    required this.isGenesis,
  });

  factory MintPodModel.fromJson(Map json) => MintPodModel(
    podId: json['NFTId'],
    rarity: json['Rarity'],
    hashPower: json['HashPower'],
    isGenesis: json['Genesis'],
  );

}