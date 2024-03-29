import 'package:app/modules/boost-pod/application/stores/boost_pod.store.dart';
import "package:app/modules/mining/application/mining.controller.dart";
import 'package:app/modules/mining/application/widgets/mining_boost_pod.widget.dart';
import "package:app/stores/mining.store.dart";
import "package:app/stores/user-hash-power.store.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "package:app/modules/mining/application/widgets/mining-card.widget.dart";
import "package:app/modules/mining/application/widgets/mining-global-stats.widget.dart";
import "package:app/modules/mining/application/widgets/mining-pod-list.widget.dart";
import "package:app/modules/mining/application/widgets/mining-user-stats.widget.dart";

class MiningView extends GetView<MiningController> {
  const MiningView({Key? key}) : super(key: key);

  static const kPadding = 10.0;

  MiningStore get miningStore => Get.find<MiningStore>();
  UserHashPowerStore get hashPowerStore => Get.find<UserHashPowerStore>();

  refresh() {
    return Future.wait([
      miningStore.reload(),
      hashPowerStore.reload(),
      BoostPodStore.to.reload(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refresh(),
          child: ListView(
            padding: const EdgeInsets.all(kPadding),
            children: [
              MiningCardWidget(
                title: "My Stats",
                child: MiningUserStatsWidget(miningStore: miningStore),
              ),
              const SizedBox(height: 10),
              MiningCardWidget(
                title: "Global Stats",
                child: MiningGlobalStatsWidget(miningStore: miningStore),
              ),
              const SizedBox(height: 10),
              MiningCardWidget(
                title: "Pod Boost",
                child: MiningBoostPodWidget(),
              ),
              const SizedBox(height: 10),
              MiningCardWidget(
                title: "POD List",
                child: MiningPodListWidget(miningStore: miningStore),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
