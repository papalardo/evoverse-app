import 'package:app/modules/boost-pod/application/stores/boost_pod.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';

class MiningBoostPodWidget extends StatelessWidget {
  const MiningBoostPodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoostPodStore.to.when(
      busy: () => List.generate(3, (index) {
        return MainCardItemWidget.shimmer(usingTitle: true);
      }).toColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        separator: const SizedBox(height: 5),
      ),
      done: (state) => [
        MainCardItemWidget(
          title: "Epic Boost Cost",
          icon: SvgPicture.asset(asset("svg/boost.svg")),
          value: state.epicBootCost.toString(),
        ),
        MainCardItemWidget(
          title: "Legendary Boost Cost",
          icon: SvgPicture.asset(asset("svg/boost.svg")),
          value: state.legendaryBoostCost.toString(),
        ),
        MainCardItemWidget(
          title: "Boost Duration",
          icon: SvgPicture.asset(asset("svg/boost.svg")),
          value: "${state.boostDuration.inDays}",
          afterValue: Text(" days"),
        ),
      ].toColumn(
        separator: const SizedBox(height: 5),
      )
    );
  }
}
