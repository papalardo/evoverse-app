class MiningHistoryModel {
  String date;
  double epwToClaim;
  int id;
  int podAmount;
  bool processed;
  double totalHashPower;
  String walletAddress;
  int walletId;

  MiningHistoryModel({
    required this.date,
    required this.epwToClaim,
    required this.id,
    required this.podAmount,
    required this.processed,
    required this.totalHashPower,
    required this.walletAddress,
    required this.walletId,
  });

  static fromJson(Map json) => MiningHistoryModel(
    date: json['Date'],
    epwToClaim: json['EPWToClaim'],
    id: json['Id'],
    podAmount: json['PodAmount'],
    processed: json['Processed'],
    totalHashPower: json['TotalHashPower'],
    walletAddress: json['WalletAddress'],
    walletId: json['WalletId'],
  );
}