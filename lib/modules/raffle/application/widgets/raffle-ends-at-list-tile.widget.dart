import "package:app/modules/raffle/application/stores/raffle-data.store.dart";
import "package:app/utils/date.utils.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/widgets/main-card-item.widget.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/instance_manager.dart";

class RaffleEndsAtListTile extends StatelessWidget {
  const RaffleEndsAtListTile({Key? key}) : super(key: key);

  RaffleDataStore get store => Get.find<RaffleDataStore>();

  @override
  Widget build(BuildContext context) {
    return store.when(
        busy: () => MainCardItemWidget.shimmer(usingTitle: true),
        done: (state) => MainCardItemWidget(
          icon: SvgPicture.asset(asset("svg/hourglass.svg")),
          title: "Ends at",
          value: AppDateUtils.toBrDateFormat(state.endsAt).toString(),
        )
    );
  }
}
