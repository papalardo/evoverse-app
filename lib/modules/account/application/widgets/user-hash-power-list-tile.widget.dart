import "package:app/stores/user-hash-power.store.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/number.dart";
import "package:app/utils/theme/app.palette.dart";
import "package:app/utils/widgets/conditional.widget.dart";
import "package:app/utils/widgets/main-card-item.widget.dart";
import "package:flutter/material.dart";
import "package:get/instance_manager.dart";
import "package:styled_widget/styled_widget.dart";

class UserHashPowerListTile extends StatelessWidget {
  const UserHashPowerListTile({Key? key}) : super(key: key);

  UserHashPowerStore get userHashPower => Get.find<UserHashPowerStore>();

  @override
  Widget build(BuildContext context) {
    return userHashPower.when(
      busy: () => MainCardItemWidget.shimmer(usingTitle: true),
      done: (playerHashPower) => MainCardItemWidget(
        title: "Hash Power",
        icon: Image.asset(asset("images/hashpower-fan-center.png")),
        value: Number.toCurrency(playerHashPower.hpTotal),
        child: Conditional(playerHashPower.bonus > 0,
          onTrue: () => Text("+${playerHashPower.bonus}%")
            .fontSize(10)
            .fontWeight(FontWeight.bold)
            .textColor(AppPalette.green400)
            .padding(left: 5),
          onFalse: () => const SizedBox(),
        ),
      )
    );
  }
}
