import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/modules/account/infra/models/pod-count.model.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPodsSection extends GetView<AccountController> {
  const AccountPodsSection({Key? key}) : super(key: key);

  Map<String, PodCount> get pods => controller.pods.asMap()
      .map((key, pod) => MapEntry(pod.rarity.toLowerCase(), pod));

  @override
  Widget build(BuildContext context) {

    return MainCardWidget(
      title: "My PODs",
      child: Wrap(
          runSpacing: 8,
          children: [
            podCard('legendary'),
            podCard('epic'),
            podCard('rare'),
            podCard('common'),
          ],
      ),
    );
  }

  Widget podCard(String rarity) {
    var pod = pods[rarity] ?? PodCount(rarity: rarity, qty: 0);

    var assetPath = "lib/assets/images/pod-rarities/$rarity.png";
    return MainCardItemWidget(
      icon: Image.asset(assetPath),
      value: "${pod.qty} #${rarity.capitalizeFirst}",
    );
  }

}
