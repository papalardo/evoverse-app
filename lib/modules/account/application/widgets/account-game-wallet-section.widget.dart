import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'user-common-toolkit-list-tile.widget.dart';
import 'user-ekey-list-tile.widget.dart';
import 'user-epw-amount-list-tile.widget.dart';
import 'user-evs-amount-list-tile.widget.dart';
import 'user-genesis-toolkit-list-tile.widget.dart';
import 'user-hash-power-list-tile.widget.dart';
import 'user-hex-toolkit-list-tile.widget.dart';

class AccountGameWalletSection extends GetView<AccountController> {
  const AccountGameWalletSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      title: "Game wallet",
      child: const [
        UserEpwAmountListTile(),
        UserEvsAmountListTile(),
        UserHashPowerListTile(),
        UserCommonToolkitListTile(),
        UserHexToolkitListTile(),
        UserGenesisToolkitListTile(),
        UserEkeyListTile(),
      ].toColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        separator: const SizedBox(height: 5),
      ),
    );
  }
}
