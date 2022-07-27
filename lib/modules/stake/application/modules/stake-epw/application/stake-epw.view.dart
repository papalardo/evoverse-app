import "package:app/stores/stake.store.dart";
import "package:app/stores/user-accout.store.dart";
import "package:app/stores/user-hash-power.store.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/number.dart";
import "package:app/utils/widgets/conditional.widget.dart";
import "package:app/utils/widgets/main-card-item.widget.dart";
import "package:app/utils/widgets/main-card.widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:styled_widget/styled_widget.dart";

import "package:app/modules/stake/application/modules/stake-epw/application/stake-epw.controller.dart";

class StakeEpwView extends StatelessWidget {
  const StakeEpwView({Key? key}) : super(key: key);

  StakeEpwController get controller => Get.find<StakeEpwController>();

  StakeStore get stakeStore => Get.find<StakeStore>();

  UserAccountStore get accountStore => Get.find<UserAccountStore>();

  UserHashPowerStore get hashPowerStore => Get.find<UserHashPowerStore>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.unstakeMode ? "Unstake EPW" : "Stake EPW"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("Amount"),
                helperText: "min: 100"
              ),
              onChanged: (v) => controller.setAmount(v),
              initialValue: controller.amount,
            ),
            const SizedBox(height: 20),
            MainCardWidget(
              title: "Preview",
              child: [
                accountStore.when(
                  busy: () => MainCardItemWidget.shimmer(usingTitle: true),
                  done: (account) => MainCardItemWidget(
                    title: "Wallet EPW",
                    icon: Image.asset(asset("images/rpw_verde.png")),
                    value: "${Number.toCurrency(account.epw)} EPW",
                  ),
                ),
                GetBuilder<StakeEpwController>(
                  builder: (_) => Conditional(controller.isLoading(),
                    onTrue: () => List.generate(4, (idx) => MainCardItemWidget
                        .shimmer(usingTitle: true))
                        .toColumn(
                        separator: const SizedBox(height: 5),
                        crossAxisAlignment: CrossAxisAlignment.start
                    ),
                    onFalse: () => content()
                      .toColumn(
                        separator: const SizedBox(height: 5),
                        crossAxisAlignment: CrossAxisAlignment.start
                      )
                  )
                )
              ].toColumn(
                separator: const SizedBox(height: 5),
                crossAxisAlignment: CrossAxisAlignment.start
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async => controller.stake()
                .then((_) => stakeStore.reload()),
              child: const Text("Confirm")
            )
          ],
        ).paddingOnly(left: 10, right: 10, bottom: 10),
      ),
    );
  }

  List<Widget> content() {
    var preview = controller.preview;
    return [
      stakeStore.when(
        done: (stake) => MainCardItemWidget(
          title: "Current EPW Staked",
          icon: Image.asset(asset("images/rpw_verde.png")),
          value: "${Number.toCurrency(stake.userTotalStaked)} EPW",
        ),
      ),
      MainCardItemWidget(
        title: "New EPW Staked",
        icon: Image.asset(asset("images/rpw_verde.png")),
        value: "${Number.toCurrency(preview.newStakeTotal)} EPW",
      ),
      hashPowerStore.when(
        done: (userHashPower) => [
          MainCardItemWidget(
              title: "Hash Power Bonus",
              icon: const Icon(Icons.arrow_circle_up_outlined)
                  .iconColor(Colors.green)
                  .iconSize(30),
              value: "${preview.newHashPowerBonus}%",
              afterValue: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Conditional(controller.unstakeMode,
                    onTrue: () => Text("- ${userHashPower.bonus - preview.newHashPowerBonus}%")
                        .fontSize(10)
                        .textColor(Colors.red),
                    onFalse: () => Text("+ ${preview.newHashPowerBonus - userHashPower.bonus}%")
                        .fontSize(10)
                        .textColor(Colors.green)
                ),
              )
          ),
          MainCardItemWidget(
              title: "Total Hash Power",
              icon: Padding(
                padding: const EdgeInsets.all(3),
                child: Image.asset(asset("images/fan.png")),
              ),
              value: Number.toCurrency(preview.newTotalHashPower),
              afterValue: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Conditional(controller.unstakeMode,
                    onTrue: () => Text("- ${Number.toCurrency(userHashPower.hpTotal - preview.newTotalHashPower)}")
                        .fontSize(10)
                        .textColor(Colors.red),
                    onFalse: () => Text("+ ${Number.toCurrency(preview.newTotalHashPower - userHashPower.hpTotal)}")
                        .fontSize(10)
                        .textColor(Colors.green)
                ),
              )
          ),
        ].toColumn(
            separator: const SizedBox(height: 5),
            crossAxisAlignment: CrossAxisAlignment.start
        )
      ),
      stakeStore.when(
        done: (stake) => MainCardItemWidget(
          title: "EKEY Rewards",
          icon: Image.asset(asset("images/e-key.png")),
          value: "${Number.toCurrency(preview.newDailyEkey, 4)} EKEY/day",
          afterValue: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Conditional(controller.unstakeMode,
                onTrue: () => Text("- ${Number.toCurrency(stake.eKeyDaily - preview.newDailyEkey, 3)}")
                    .fontSize(10)
                    .textColor(Colors.red),
                onFalse: () => Text("+ ${Number.toCurrency(preview.newDailyEkey - stake.eKeyDaily, 3)}")
                    .fontSize(10)
                    .textColor(Colors.green)
            ),
          )
        )
      ),
    ];
  }
}
