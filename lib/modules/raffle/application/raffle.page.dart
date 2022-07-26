import 'package:app/modules/config/utils/config-keys.dart';
import 'package:app/utils/date.utils.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/logger.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:app/utils/widgets/buttons/tiny.button.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:app/utils/widgets/text/date-countdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

import 'stores/raffle-data.store.dart';
import 'widgets/last-winners/last-winners-list-view.dart';
import 'widgets/player-tickets-list-tile.widget.dart';
import 'widgets/raffle-ends-at-list-tile.widget.dart';
import 'widgets/raffle-starts-at-list-tile.widget.dart';
import 'widgets/raffle-time-remaining-list-tile.widget.dart';
import 'widgets/session-number-list-tile.widget.dart';

class RafflePage extends StatelessWidget {
  const RafflePage({Key? key}) : super(key: key);

  RaffleDataStore get store => Get.find<RaffleDataStore>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text("Raffles".toUpperCase())),
      body: RefreshIndicator(
        onRefresh: () async => store.reload(),
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            MainCardWidget(
              title: "Evo Raffle",
              child: const [
                SessionNumberListTile(),
                PlayerTicketsListTile(),
                RaffleStartsAtListTile(),
                RaffleEndsAtListTile(),
                RaffleTimeRemainingListTile(),
              ].toColumn(
                separator: const SizedBox(height: 5),
                crossAxisAlignment: CrossAxisAlignment.start
              )
            ),
            const SizedBox(height: 10),
            MainCardWidget(
              title: "Last Week Winners",
              child: const LastWinnersListView()
            ),
          ],
        ),
      )
    );
  }
}
