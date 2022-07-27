import "package:app/stores/user-accout.store.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/number.dart";
import "package:app/utils/widgets/main-card-item.widget.dart";
import "package:flutter/material.dart";
import "package:get/instance_manager.dart";

class UserEvsAmountListTile extends StatelessWidget {
  const UserEvsAmountListTile({Key? key}) : super(key: key);

  UserAccountStore get userAccountStore => Get.find<UserAccountStore>();

  @override
  Widget build(BuildContext context) {
    return userAccountStore.when(
        busy: () => MainCardItemWidget.shimmer(usingTitle: true),
        done: (account) => MainCardItemWidget(
          title: "EVS",
          icon: Image.asset(asset("images/evo_head.png")),
          value: Number.toCurrency(account.evs),
        )
    );
  }
}
