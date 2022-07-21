import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/modules/ethereum/infra/datasource/ethereum.datasource.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/services/storage/storage.service.dart';
import 'package:app/stores/user-accout.store.dart';
import 'package:app/stores/user-pods.store.dart';
import 'package:app/stores/user-workshop.store.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/account-game-wallet-section.widget.dart';
import 'widgets/account-pods-section.widget.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);

  static const kPadding = 10.0;

  UserWorkshopStore get userWorkshopStore => Get.find<UserWorkshopStore>();
  UserAccountStore get userAccountStore => Get.find<UserAccountStore>();
  UserPodsStore get userPodsStore => Get.find<UserPodsStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            userWorkshopStore.reload(),
            userAccountStore.reload(),
            userPodsStore.reload(),
          ]);
        },
        child: ListView(
          padding: EdgeInsets.only(
              top: Get.mediaQuery.padding.top + kPadding,
              bottom: kPadding,
              left: kPadding,
              right: kPadding
          ),
          children: const [
            AccountGameWalletSection(),
            SizedBox(height: kPadding),
            AccountPodsSection()
          ],
        ),
      ),
    );
  }
}
