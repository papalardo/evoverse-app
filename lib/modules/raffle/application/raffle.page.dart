import "package:app/utils/widgets/app-scaffold.widget.dart";
import "package:app/utils/widgets/main-card.widget.dart";
import "package:flutter/material.dart";
import "package:get/instance_manager.dart";
import "package:styled_widget/styled_widget.dart";

import "package:app/modules/raffle/application/stores/raffle-data.store.dart";
import "package:app/modules/raffle/application/widgets/last-winners/last-winners-list-view.dart";
import "package:app/modules/raffle/application/widgets/player-tickets-list-tile.widget.dart";
import "package:app/modules/raffle/application/widgets/raffle-ends-at-list-tile.widget.dart";
import "package:app/modules/raffle/application/widgets/raffle-starts-at-list-tile.widget.dart";
import "package:app/modules/raffle/application/widgets/raffle-time-remaining-list-tile.widget.dart";
import "package:app/modules/raffle/application/widgets/session-number-list-tile.widget.dart";

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
          padding: const EdgeInsets.all(10),
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
            const MainCardWidget(
              title: "Last Week Winners",
              child: LastWinnersListView()
            ),
          ],
        ),
      )
    );
  }
}
