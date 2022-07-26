import 'package:app/modules/config/utils/config-keys.dart';
import 'package:app/utils/logger.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:app/utils/widgets/text/date-countdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

import 'stores/raffle-data.store.dart';

class RafflePage extends StatelessWidget {
  const RafflePage({Key? key}) : super(key: key);

  RaffleDataStore get store => Get.find<RaffleDataStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: store.when(
        busy: () => Center(child: CircularProgressIndicator()),
        done: (state) => ListView(
          children: [
            Text("price ${state.ticketPrice} ${state.ticketCurrency}"),
            MainCardWidget(
              title: "Evo Raffle #${state.id}",
              child: [
                [
                  const Text("Starts at ").bold(),
                  Text(state.startedAt.toString())
                    .fontSize(12),
                ].toRow(),
                [
                  const Text("Ends at ").bold(),
                  Text(state.endsAt.toString())
                    .fontSize(12),
                ].toRow(),
                [
                  const Text("Remaining ").bold(),
                  DateCountdownWidget(
                    endsAt: state.endsAt,
                    // timezone: 'America/Sao_Paulo',
                    onOver: () => store.reload(),
                    style: TextStyle(fontSize: 12),
                  ),
                ].toRow(),
              ].toColumn(
                separator: const SizedBox(height: 5),
                crossAxisAlignment: CrossAxisAlignment.start
              )
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.winners.length,
              itemBuilder: (_, idx) {
                var winner = state.winners[idx];

                return ListTile(
                  title: Text(winner.playerName),
                  subtitle: Wrap(
                    direction: Axis.vertical,
                    children: List<Widget>
                      .from(winner.rewards.map((reward) {
                        return Text("${reward.amount}x ${reward.name}");
                      })),
                  )
                );
              }
            ),
          ],
        )
      )
    );
  }
}
