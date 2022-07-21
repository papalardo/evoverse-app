import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/stores/mining.store.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/widgets/infinite-rotation.widget.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/secondary-list-view.dart';
import 'package:flutter/material.dart';

import 'mining-item-info.widget.dart';
import 'mining-pool-reset-time.widget.dart';

class MiningGlobalStatsWidget extends StatelessWidget {
  final MiningStore miningStore;

  const MiningGlobalStatsWidget({
    Key? key,
    required this.miningStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return miningStore.when(
      busy: () => SecondaryListView(
        itemExtent: 60,
        children: List.generate(5, (index) => MainCardItemWidget.shimmer(usingTitle: true)),
      ),
      done: (miningData) {
        var multiplyFactor = miningData.totalHashPowerDaily / miningData.totalHashPowerPool;

        return SecondaryListView(
          itemExtent: 60,
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
              value: "${Number.toCurrency(multiplyFactor)}x",
              icon: Image.asset('lib/assets/images/rpw_verde.png'),
            ),
            MiningItemInfoWidget(
              title: "Gain estimated",
              value: Number.toCurrency(multiplyFactor * miningData.userTotalHashPower),
              icon: Image.asset('lib/assets/images/rpw_verde.png'),
            ),
            MiningItemInfoWidget(
              title: "Mining Pool Reset Cycle",
              child: MiningPoolResetTimeWidget(miningStore: miningStore),
              icon: Image.asset('lib/assets/images-animated/hourglass.gif'),
            ),
          ],
        );
      }
    );

  }
}
