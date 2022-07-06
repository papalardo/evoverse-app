class ClaimCostModel {
  double bestClaimTimeRemaining;
  double claimCost;
  int claimPercent;
  int daysRemaining;

  ClaimCostModel({
    required this.bestClaimTimeRemaining,
    required this.claimCost,
    required this.claimPercent,
    required this.daysRemaining,
  });

  static fromJson(Map json) => ClaimCostModel(
    bestClaimTimeRemaining: json['best_claim_time_remaining'],
    claimCost: json['claim_cost'],
    claimPercent: json['claim_percent'],
    daysRemaining: json['days_remaining'],
  );
}