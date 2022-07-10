import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/account-game-wallet-section.widget.dart';
import 'widgets/account-pods-section.widget.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);

  static const kPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: GetBuilder<AccountController>(
        builder: (c) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.userWorkshopStore.reload();
              controller.userAccountStore.reload();
              controller.userPodsStore.reload();
            },
            child: ListView(
              padding: EdgeInsets.only(
                  top: Get.mediaQuery.padding.top + kPadding,
                  bottom: kPadding,
                  left: kPadding,
                  right: kPadding
              ),
              children: [
                AccountGameWalletSection(
                  userAccountStore: c.userAccountStore,
                  userWorkshopStore: c.userWorkshopStore,
                ),
                const SizedBox(height: kPadding),
                AccountPodsSection(userPodsStore: c.userPodsStore)
              ],
            ),
          );
        },
      ),
    );
  }
}
