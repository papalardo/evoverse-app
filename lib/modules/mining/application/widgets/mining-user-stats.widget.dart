import "package:app/modules/mining/application/mining.controller.dart";
import "package:app/modules/mining/infra/models/mining.model.dart";
import "package:app/stores/mining.store.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/number.dart";
import "package:app/utils/theme/app.palette.dart";
import "package:app/utils/toast/toast.dart";
import "package:app/utils/widgets/conditional.widget.dart";
import "package:app/utils/widgets/dialog/app-dialog.dart";
import "package:app/utils/widgets/main-card-item.widget.dart";
import "package:app/utils/widgets/secondary-list-view.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:styled_widget/styled_widget.dart";

class MiningUserStatsWidget extends GetView<MiningController> {
  final MiningStore miningStore;

  const MiningUserStatsWidget({
    Key? key,
    required this.miningStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return miningStore.when(
        busy: () => SecondaryListView(
          itemExtent: 60,
          children: List.generate(2, (index) => MainCardItemWidget.shimmer(usingTitle: true)),
        ),
        done: (MiningModel miningData) {
          return [
            SecondaryListView(
              itemExtent: 60,
              children: [
                MainCardItemWidget(
                  title: "Available EPW",
                  value: Number.toCurrency(miningData.epwToClaim),
                  icon: Image.asset("lib/assets/images/rpw_verde.png"),
                ),
                MainCardItemWidget(
                  title: "My Hash Power",
                  value: Number.toCurrency(miningData.userTotalHashPower),
                  icon: Image.asset(asset("images/hashpower-fan-center.png")),
                  child: Conditional(miningData.hashPowerBonus > 0,
                    onTrue: () => Text("+${miningData.hashPowerBonus}%")
                      .fontSize(10)
                      .fontWeight(FontWeight.bold)
                      .textColor(AppPalette.green400)
                      .padding(left: 5),
                  )
                ),
              ],
            ),
            [
              ElevatedButton(
                  onPressed: () => claimEpw(
                    context: context,
                    mining: miningData,
                  ),
                  child: Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text("Claim"),
                      Text("(${miningData.claimCost.claimPercent}% Fee)")
                          .fontWeight(FontWeight.w200)
                          .fontSize(10)
                    ],
                  )
              ),
              Text("Free claim in ${miningData.claimCost.daysRemaining} days.")
            ].toColumn()
          ].toColumn();
        }
    );
  }

  void claimEpw({
    required BuildContext context,
    required MiningModel mining,
  }) {
    showDialog(
      context: context,
      builder: (context) => AppDialog.confirm(
          context: context,
          icon: Image.asset(asset("images/rpw_verde.png")),
          title: "You sure?",
          message: "You will receive "
              "${Number.toCurrency(mining.epwToClaim - mining.claimCost.claimCost)} "
              "EPW",
          onConfirm: () async {
            Navigator.of(context).pop();
            try {
              await controller.loader.wait(() => controller.claim());
              Toast.show("Claimed successfully");
            } catch (e) {
              Toast.danger("Error to claim: ${e.toString()}");
            }
          }
      ),
    );
  }
}
