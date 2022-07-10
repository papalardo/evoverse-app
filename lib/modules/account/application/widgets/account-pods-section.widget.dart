import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/modules/account/infra/models/pod-count.model.dart';
import 'package:app/stores/user-pods.store.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pod-card.widget.dart';

class AccountPodsSection extends GetView<AccountController> {
  final UserPodsStore userPodsStore;

  const AccountPodsSection({
    Key? key,
    required this.userPodsStore,
  }) : super(key: key);

  Map<String, PodCount> get pods => userPodsStore.pods.asMap()
      .map((key, pod) => MapEntry(pod.rarity.toLowerCase(), pod));

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      title: "My PODs",
      child: userPodsStore.when(
        busy: () => ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemExtent: 35,
          children: List.generate(4, (index) => MainCardItemWidget.shimmer()),
        ),
        done: () => ListView(
          padding: EdgeInsets.zero,
          itemExtent: 35,
          shrinkWrap: true,
          primary: false,
          children: [
            podCard('Legendary'),
            podCard('Epic'),
            podCard('Rare'),
            podCard('Common'),
          ],
        )
      ),
    );

  }

  Widget podCard(String rarity) {
    var pod = pods[rarity.toLowerCase()] ?? PodCount(rarity: rarity, qty: 0);

    return PodCardWidget(
      qty: pod.qty,
      rarity: pod.rarity,
    );
  }

}
