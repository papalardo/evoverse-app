import 'package:app/modules/mining/application/mining.controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.place),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AppDialog.confirm(
              context: context,
              title: "You sure?",
              message: "Essa ação não poderá ser desfeita",
              onConfirm: () => Navigator.of(context).pop()
            ),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.miningStore.reload(),
        child: ListView(
          padding: EdgeInsets.only(
              top: Get.mediaQuery.padding.top + kPadding,
              bottom: kPadding,
              left: kPadding,
              right: kPadding
          ),
          children: [
            MiningCardWidget(
              title: "My Stats",
              child: MiningUserStatsWidget(miningStore: controller.miningStore),
            ),
            const SizedBox(height: 10),
            MiningCardWidget(
              title: "Global Stats",
              child: MiningGlobalStatsWidget(miningStore: controller.miningStore),
            ),
            const SizedBox(height: 10),
            MiningCardWidget(
              title: "POD List",
              child: MiningPodListWidget(miningStore: controller.miningStore),
            ),
          ],
        ),
      ),
    );

  }
}
