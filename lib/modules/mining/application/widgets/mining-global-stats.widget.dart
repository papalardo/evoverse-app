import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/widgets/infinite-rotation.widget.dart';
import 'package:flutter/material.dart';

import 'mining-item-info.widget.dart';
import 'mining-pool-reset-time.widget.dart';

class MiningGlobalStatsWidget extends StatelessWidget {
  final MiningModel miningData;

  const MiningGlobalStatsWidget({
    Key? key,
    required this.miningData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var multiplyFactor = miningData.totalHashPowerDaily / miningData.totalHashPowerPool;

    return Wrap(
      runSpacing: 8,
      children: [
        MiningItemInfoWidget(
          title: "Daily Mining Pool",
          value: Number.toCurrency(miningData.totalHashPowerDaily),
          icon: Image.asset('lib/assets/images/rpw_verde.png'),
        ),
        MiningItemInfoWidget(
          title: "Estimated Global Hash Power",
          value: Number.toCurrency(miningData.totalHashPowerPool),
          icon: Image.asset('lib/assets/images/rpw_verde.png'),
        ),
        MiningItemInfoWidget(
          title: "Multiply factor",
          value: Number.toCurrency(multiplyFactor),
          icon: Image.asset('lib/assets/images/rpw_verde.png'),
        ),
        MiningItemInfoWidget(
          title: "Gain estimated",
          value: Number.toCurrency(multiplyFactor * miningData.userTotalHashPower),
          icon: Image.asset('lib/assets/images/rpw_verde.png'),
        ),
        MiningItemInfoWidget(
          title: "Mining Pool Reset Cycle",
          child: const MiningPoolResetTimeWidget(),
          icon: InfiniteRotationWidget(
              child: Image.asset('lib/assets/images/hourglass.png')),
        ),
      ],
    );
  }
}
