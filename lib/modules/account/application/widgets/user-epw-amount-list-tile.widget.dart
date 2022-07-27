import "package:app/stores/user-accout.store.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/number.dart";
import "package:app/utils/widgets/main-card-item.widget.dart";
import "package:flutter/material.dart";
import "package:get/instance_manager.dart";

class UserEpwAmountListTile extends StatelessWidget {
  const UserEpwAmountListTile({Key? key}) : super(key: key);

  UserAccountStore get userAccountStore => Get.find<UserAccountStore>();

  @override
  Widget build(BuildContext context) {
    return userAccountStore.when(
        busy: () => MainCardItemWidget.shimmer(usingTitle: true),
        done: (account) => MainCardItemWidget(
          title: "EPW",
          icon: Image.asset(asset("images/rpw_verde.png")),
          value: Number.toCurrency(account.epw),
        )
    );
  }
}
