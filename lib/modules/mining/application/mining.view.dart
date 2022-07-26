import 'package:app/modules/mining/application/mining.controller.dart';
import 'package:app/stores/mining.store.dart';
import 'package:app/stores/user-hash-power.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/mining-card.widget.dart';
import 'widgets/mining-global-stats.widget.dart';
import 'widgets/mining-pod-list.widget.dart';
import 'widgets/mining-user-stats.widget.dart';

class MiningView extends GetView<MiningController> {
  const MiningView({Key? key}) : super(key: key);

  static const kPadding = 10.0;

  MiningStore get miningStore => Get.find<MiningStore>();
  UserHashPowerStore get hashPowerStore => Get.find<UserHashPowerStore>();

  refresh() {
    return Future.wait([
      miningStore.reload(),
      hashPowerStore.reload()
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
