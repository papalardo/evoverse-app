import 'package:app/modules/mining/infra/models/pod.model.dart';

import 'claim-cost.model.dart';
import 'mining-history.model.dart';

class MiningModel {
  num hashPowerBonus;
  num epwToClaim;
  num energizeCost;
  num userTotalHashPower;
  num userBaseHashPower;
  num totalHashPowerPool;
  num totalHashPowerDaily;

  List<MiningHistoryModel> miningHistory;
  ClaimCostModel claimCost;
  List<PodModel> pods;

  MiningModel({
    required this.hashPowerBonus,
    required this.userTotalHashPower,
    required this.epwToClaim,
    required this.energizeCost,
    required this.userBaseHashPower,
    required this.totalHashPowerPool,
    required this.totalHashPowerDaily,
    required this.miningHistory,
    required this.claimCost,
    required this.pods,
  });

  static fromJson(Map json) => MiningModel(
    hashPowerBonus: json['HashPowerBonus'],
    epwToClaim: json['EPWToClaim'],
    energizeCost: json['EnergizeAllCost'],
    userTotalHashPower: json['PlayerTotalHashPower'],
    userBaseHashPower: json['PlayerHashPowerBase'],
    totalHashPowerPool: json['HashPowerPool'],
    totalHashPowerDaily: json['DailyMiningPool'][0],
    miningHistory: List.from(json['MiningHistory'].map((e) => MiningHistoryModel.fromJson(e))),
    claimCost: ClaimCostModel.fromJson(json['ClaimCost']),
    pods: List.from(json['Pods'].map((e) => PodModel.fromJson(e))),
  );
}