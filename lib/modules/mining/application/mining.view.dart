import 'package:app/modules/mining/application/mining.controller.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/mining-card.widget.dart';
import 'widgets/mining-global-stats.widget.dart';
import 'widgets/mining-pod-list.widget.dart';
import 'widgets/mining-user-stats.widget.dart';

class MiningView extends GetView<MiningController> {
  const MiningView({Key? key}) : super(key: key);

  static const kPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (_) {
      if (controller.miningData == null) {
        return const SizedBox();
      }

      var mining = controller.miningData!;

      return AppScaffold(
        body: ListView(
          padding: EdgeInsets.only(
            top: Get.mediaQuery.padding.top + kPadding,
            bottom: kPadding,
            left: kPadding,
            right: kPadding
          ),
          children: [
            MiningCardWidget(
              title: "My Stats",
              child: MiningUserStatsWidget(miningData: mining),
            ),
            const SizedBox(height: 10),
            MiningCardWidget(
              title: "Global Stats",
              child: MiningGlobalStatsWidget(miningData: mining),
            ),
            const SizedBox(height: 10),
            MiningCardWidget(
              title: "POD List",
              child: MiningPodListWidget(miningData: mining),
            ),
          ],
        ),
      );
    });

  }
}
