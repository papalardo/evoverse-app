import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/stores/user-accout.store.dart';
import 'package:app/stores/user-workshop.store.dart';
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
  final UserAccountStore userAccountStore;
  final UserWorkshopStore userWorkshopStore;

  const AccountGameWalletSection({
    Key? key,
    required this.userAccountStore,
    required this.userWorkshopStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      title: "Game wallet",
      child: Column(
        children: [
          userAccountStore.when(
            busy: () => loader(3),
            done: () => ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemExtent: 60,
              primary: false,
              children: [
                MainCardItemWidget(
                  title: "EPW",
                  icon: Image.asset(asset("images/rpw_verde.png")),
                  value: Number.toCurrency(userAccountStore.account!.epw),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: MainCardItemWidget(
                        title: "Hash Power",
                        icon: Image.asset(asset("images/hashpower-fan-center.png")),
                        value: Number.toCurrency(userAccountStore.playerHashPower!.hpTotal),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Conditional(userAccountStore.playerHashPower!.bonus > 0,
                      onTrue: () => n.Text("+${userAccountStore.playerHashPower!.bonus}%")
                        ..fontSize = 10
                        ..color = AppPalette.green400,
                      onFalse: () => const SizedBox(),
                    ),
                  ],
                ),
                MainCardItemWidget(
                  title: "EVS",
                  icon: Image.asset(asset("images/evo_head.png")),
                  value: Number.toCurrency(userAccountStore.account!.evs),
                ),
              ],
            )
          ),
          userWorkshopStore.when(
              busy: () => loader(4),
              done: () => ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                itemExtent: 60,
                children: [
                  MainCardItemWidget(
                    title: "Common toolkit",
                    icon: Image.asset(asset("images/toolkit-common.png")),
                    value: Number.toCurrency(userWorkshopStore.workshop!.commonToolkitsTotal),
                  ),
                  MainCardItemWidget(
                    title: "Hex toolkit",
                    icon: Image.asset(asset("images/toolkit-hex.png")),
                    value: Number.toCurrency(userWorkshopStore.workshop!.hexToolkitsTotal),
                  ),
                  MainCardItemWidget(
                    title: "Genesis toolkit",
                    icon: Image.asset(asset("images/toolkit-genesis.png")),
                    value: Number.toCurrency(userWorkshopStore.workshop!.genesisToolkitsTotal),
                  ),
                  MainCardItemWidget(
                    title: "Keys",
                    icon: Image.asset(asset("images/e-key.png")),
                    value: Number.toCurrency(userWorkshopStore.workshop!.eKeys),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  Widget loader(int count) => ListView(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    itemExtent: 60,
    children: List.generate(count, (index) => MainCardItemWidget.shimmer(usingTitle: true)),
  );
}
