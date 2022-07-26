import 'package:app/modules/raffle/application/stores/raffle-data.store.dart';
import 'package:app/modules/raffle/application/widgets/last-winners/last-winner-list-tile.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/widgets/loader/shimmer-wrapper.widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

class LastWinnersListView extends StatelessWidget {
  const LastWinnersListView({Key? key}) : super(key: key);

  RaffleDataStore get store => Get.find<RaffleDataStore>();

  Widget separator() => const SizedBox(height: 3);

  @override
  Widget build(BuildContext context) {
    return store.when(
      busy: () => ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemCount: 5,
        itemBuilder: (_, __) => LastWinnerListTile.shimmer(),
        separatorBuilder: (_, __) => separator(),
      ),
      done: (state) => ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemCount: state.winners.length,
        itemBuilder: (_, idx) => LastWinnerListTile(winner: state.winners[idx]),
        separatorBuilder: (_, __) => separator(),
      )
    );
  }
}
