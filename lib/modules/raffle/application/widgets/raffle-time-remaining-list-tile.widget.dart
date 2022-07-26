import 'package:app/modules/raffle/application/stores/raffle-data.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/text/date-countdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

class RaffleTimeRemainingListTile extends StatelessWidget {
  const RaffleTimeRemainingListTile({Key? key}) : super(key: key);

  RaffleDataStore get store => Get.find<RaffleDataStore>();

  @override
  Widget build(BuildContext context) {
    return store.when(
      busy: () => MainCardItemWidget.shimmer(usingTitle: true),
      done: (state) => MainCardItemWidget(
        icon: Image.asset(asset("images-animated/hourglass.gif")),
        title: "Time remaining",
        child: DateCountdownWidget(
          endsAt: state.endsAt,
          timezone: 'America/Sao_Paulo',
          onOver: () => store.reload(),
          style: MainCardItemWidget.valueTextStyle,
        ),
      )
    );
  }
}
