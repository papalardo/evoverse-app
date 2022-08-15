import 'package:app/modules/player-keys/application/player-keys.controller.dart';
import 'package:app/modules/player-keys/application/stores/player-keys.store.dart';
import 'package:app/modules/player-keys/application/widgets/player_key_for_sale_list_tile.widget.dart';
import 'package:app/modules/player-keys/application/widgets/player_keys_list_empty.widget.dart';
import 'package:flutter/material.dart';

class PlayerForSaleKeysList extends StatelessWidget {
  const PlayerForSaleKeysList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayerKeysStore.to.when(
      done: (state) {
        var list = PlayerKeysController.to
            .filterKeys(state)
            .map((playerKey) => PlayerKeyForSaleListTile(playerKey: playerKey))
            .toList();

        return list.isEmpty
            ? const PlayerKeysListEmpty()
            : createGrid(children: list);
      },
    );
  }

  Widget createGrid({
    required List<Widget> children,
  }) {
    return GridView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: children,
    );
  }
}
