import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountGameWalletSection extends GetView<AccountController> {
  const AccountGameWalletSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.account == null || controller.workshop == null) {
      return const SizedBox();
    }

    var account = controller.account!;
    var workshop = controller.workshop!;

    return MainCardWidget(
      title: "Game wallet",
      child: Wrap(
        runSpacing: 8,
        children: [
          MainCardItemWidget(
            title: "EPW",
            icon: Image.asset("lib/assets/images/rpw_verde.png"),
            value: Number.toCurrency(account.epw),
          ),
          MainCardItemWidget(
            title: "Hash Power",
            icon: Image.asset("lib/assets/images/hashpower-fan-center.png"),
            value: Number.toCurrency(account.epw),
          ),
          MainCardItemWidget(
            title: "EVS",
            icon: Image.asset("lib/assets/images/evo_head.png"),
            value: Number.toCurrency(account.evs),
          ),
          MainCardItemWidget(
            title: "Common toolkit",
            icon: Image.asset("lib/assets/images/toolkit-common.png"),
            value: Number.toCurrency(workshop.commonToolkitsTotal),
          ),
          MainCardItemWidget(
            title: "Hex toolkit",
            icon: Image.asset("lib/assets/images/toolkit-hex.png"),
            value: Number.toCurrency(workshop.hexToolkitsTotal),
          ),
          MainCardItemWidget(
            title: "Genesis toolkit",
            icon: Image.asset("lib/assets/images/toolkit-genesis.png"),
            value: Number.toCurrency(workshop.genesisToolkitsTotal),
          ),
          MainCardItemWidget(
            title: "Keys",
            icon: Image.asset("lib/assets/images/e-key.png"),
            value: Number.toCurrency(workshop.eKeys),
          ),
        ],
      ),
    );
  }
}
