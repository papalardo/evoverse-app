import 'package:app/modules/mining/application/mining.controller.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mining-item-info.widget.dart';
import 'package:niku/namespace.dart' as n;

class MiningUserStatsWidget extends GetView<MiningController> {
  final MiningModel miningData;

  const MiningUserStatsWidget({
    Key? key,
    required this.miningData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var claimData = miningData.claimCost;

    return Wrap(
      runSpacing: 8,
      children: [
        MiningItemInfoWidget(
          title: "Available EPW",
          value: Number.toCurrency(miningData.epwToClaim),
          icon: Image.asset('lib/assets/images/rpw_verde.png'),
        ),
        MiningItemInfoWidget(
          title: "My Hash Power",
          value: Number.toCurrency(miningData.userTotalHashPower),
          icon: Image.asset('lib/assets/images/hashpower-fan-center.png'),
          child: n.Text("+${miningData.hashPowerBonus}%")
                ..color = AppPalette.green400
                ..fontSize = 10,
        ),
        Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => controller.claim(),
                child: Wrap(
                  spacing: 5,
                  children: [
                    const Text("Claim"),
                    n.Text("(${claimData.claimPercent}% Fee)")
                      ..fontWeight = FontWeight.w200
                  ],
                )
              ),
              if (claimData.daysRemaining > 0)
                n.Text("Free claim in ${claimData.daysRemaining} days.")
                  ..color = AppPalette.gray400
            ],
          ),
        ),
      ],
    );
  }
}
