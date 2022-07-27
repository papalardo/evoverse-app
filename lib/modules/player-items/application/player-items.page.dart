import "package:app/modules/player-items/infra/models/player-item-pod.model.dart";
import "package:app/modules/player-items/infra/models/player-items.model.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/number.dart";
import "package:app/utils/widgets/app-scaffold.widget.dart";
import "package:app/utils/widgets/conditional.widget.dart";
import "package:app/utils/widgets/dialog/app-dialog.dart";
import "package:app/utils/widgets/loader/app-future-builder.widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:styled_widget/styled_widget.dart";

import "package:app/modules/player-items/application/player-items.controller.dart";
import "package:app/modules/player-items/application/widgets/pod-list-tile.widget.dart";

class PlayerItemsPage extends StatelessWidget {
  const PlayerItemsPage({Key? key}) : super(key: key);

  PlayerItemsController get controller => Get.find<PlayerItemsController>();

  static const kPadding = EdgeInsets.only(left: 10, right: 10, top: 10);

  static const separator = SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("MY PODS"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.update(),
        child: GetBuilder<PlayerItemsController>(builder: (_) {
          return AppFutureBuilder<PlayerItemsModel>(
            future: controller.getItems(),
            busy: ListView.separated(
              padding: kPadding,
              itemCount: 5,
              separatorBuilder: (_, __) => separator,
              itemBuilder: (_, __) => PodListTile.shimmer(),
            ),
            error: (error) => Text("Error: $error"),
            done: (PlayerItemsModel items) {
              return ListView.separated(
                  padding: kPadding,
                  itemCount: items.pods.length,
                  separatorBuilder: (_, __) => separator,
                  itemBuilder: (_, int index) {
                    var pod = items.pods[index];
                    return PodListTile(
                      pod: pod,
                      selected: controller.selected.contains(pod.id),
                      onTap: () => showDialogOptions(
                        context: context,
                        pod: pod,
                      ),
                    );
                  });
            },
          );
        }),
      ),
    );
  }

  showDialogOptions(
      {required BuildContext context, required PlayerItemPodModel pod}) {
    showDialog(
        context: context,
        builder: (_context) {
          return AppDialog(
              icon: Image.asset(
                  asset("images/pod-rarities/${pod.rarity.toLowerCase()}.png")),
              child: [
                Text("POD #${pod.id}"),
                [
                  Image.asset(asset("images/fan.png"), width: 15, height: 15),
                  Text(Number.toCurrency(pod.hashPowerTotal))
                      .fontSize(10)
                      .fontWeight(FontWeight.bold)
                ].toRow(
                    separator: const SizedBox(width: 5),
                    mainAxisSize: MainAxisSize.min),
                ElevatedButton(
                  child: const Text("Put to sale"),
                  onPressed: () async {
                    Navigator.of(_context).pop();
                    await Future.delayed(const Duration(milliseconds: 200));
                    showDialogToSale(
                      context: context,
                      pod: pod,
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Boost"),
                  onPressed: Conditional.fn(pod.canBoost(),
                      onTrue: () => () {
                            Navigator.of(_context).pop();
                            controller.globalLoader.wait(
                                () => controller.boostPod(pod.id), "scaffold");
                          }),
                )
              ].toColumn(
                  mainAxisSize: MainAxisSize.min,
                  separator: const SizedBox(height: 5)));
        });
  }

  showDialogToSale(
      {required BuildContext context, required PlayerItemPodModel pod}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_context) {
        return AppDialog(
          icon: Image.asset(
            asset("images/pod-rarities/${pod.rarity.toLowerCase()}.png"),
          ),
          child: [
            Text("POD #${pod.id}"),
            [
              Image.asset(asset("images/fan.png"), width: 15, height: 15),
              Text(Number.toCurrency(pod.hashPowerTotal))
                  .fontSize(10)
                  .fontWeight(FontWeight.bold)
            ].toRow(
              separator: const SizedBox(width: 5),
              mainAxisSize: MainAxisSize.min,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  controller.priceToSale = double.tryParse(v) ?? 0,
            ),
            ElevatedButton(
              child: const Text("Put to sale"),
              onPressed: () {
                Navigator.of(_context).pop();
                controller.globalLoader.wait(
                  () => controller.putSale(pod.id, controller.priceToSale),
                  "scaffold",
                );
              },
            )
          ].toColumn(
            mainAxisSize: MainAxisSize.min,
            separator: const SizedBox(height: 5),
          ),
        );
      },
    );
  }
}
