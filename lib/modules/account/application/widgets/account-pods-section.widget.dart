import 'package:app/core/app.routes.dart';
import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/modules/account/infra/models/pod-count.model.dart';
import 'package:app/stores/user-pods.store.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'pod-card.widget.dart';

class AccountPodsSection extends GetView<AccountController> {
  const AccountPodsSection({Key? key}) : super(key: key);

  UserPodsStore get userPodsStore => Get.find<UserPodsStore>();

  Map<String, PodCount> podsMapped(List<PodCount> pods) => pods
      .asMap()
      .map((key, pod) => MapEntry(pod.rarity.toLowerCase(), pod));

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      title: "My PODs",
      rightTitle: TextButton(
        onPressed: () => Get.toNamed(AppRoutes.PLAYER_ITEMS),
        child: [
          const Text("More"),
          const Icon(Icons.chevron_right)
        ].toRow(mainAxisSize: MainAxisSize.min),
        style: TextButton.styleFrom(
          primary: Colors.white,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero
        ),
      ),
      child: userPodsStore.when(
        busy: () => ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemExtent: 35,
          children: List.generate(4, (index) => MainCardItemWidget.shimmer()),
        ),
        done: (List<PodCount> pods) => ListView(
          padding: EdgeInsets.zero,
          itemExtent: 35,
          shrinkWrap: true,
          primary: false,
          children: [
            podCard(pods, 'Legendary'),
            podCard(pods, 'Epic'),
            podCard(pods, 'Rare'),
            podCard(pods, 'Common'),
          ],
        )
      ),
    );

  }

  Widget podCard(List<PodCount> pods, String rarity) {
    var pod = podsMapped(pods)[rarity.toLowerCase()] ?? PodCount(rarity: rarity, qty: 0);

    return PodCardWidget(
      qty: pod.qty,
      rarity: pod.rarity,
    );
  }

}
