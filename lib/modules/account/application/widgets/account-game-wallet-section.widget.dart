import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/conditional.widget.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niku/namespace.dart' as n;

class AccountGameWalletSection extends GetView<AccountController> {
  const AccountGameWalletSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ([
      controller.account,
      controller.workshop,
    ].contains(null)) {
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
            icon: Image.asset(asset("images/rpw_verde.png")),
            value: Number.toCurrency(account.epw),
          ),
          if (controller.playerHashPower != null)
          MainCardItemWidget(
            title: "Hash Power",
            icon: Image.asset(asset("images/hashpower-fan-center.png")),
            value: Number.toCurrency(controller.playerHashPower!.hpTotal),
            child: Conditional(controller.playerHashPower!.bonus > 0,
              onTrue: () => n.Text("+${controller.playerHashPower!.bonus}%")
                            ..fontSize = 10
                            ..color = AppPalette.green400,
            ),
          ),
          MainCardItemWidget(
            title: "EVS",
            icon: Image.asset(asset("images/evo_head.png")),
            value: Number.toCurrency(account.evs),
          ),
          MainCardItemWidget(
            title: "Common toolkit",
            icon: Image.asset(asset("images/toolkit-common.png")),
            value: Number.toCurrency(workshop.commonToolkitsTotal),
          ),
          MainCardItemWidget(
            title: "Hex toolkit",
            icon: Image.asset(asset("images/toolkit-hex.png")),
            value: Number.toCurrency(workshop.hexToolkitsTotal),
          ),
          MainCardItemWidget(
            title: "Genesis toolkit",
            icon: Image.asset(asset("images/toolkit-genesis.png")),
            value: Number.toCurrency(workshop.genesisToolkitsTotal),
          ),
          MainCardItemWidget(
            title: "Keys",
            icon: Image.asset(asset("images/e-key.png")),
            value: Number.toCurrency(workshop.eKeys),
          ),
        ],
      ),
    );
  }
}
