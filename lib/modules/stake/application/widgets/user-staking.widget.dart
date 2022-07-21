import 'package:app/core/app.routes.dart';
import 'package:app/modules/stake/application/stake.controller.dart';
import 'package:app/modules/stake/infra/models/stake.model.dart';
import 'package:app/stores/stake.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserStakingWidget extends StatelessWidget {
  const UserStakingWidget({Key? key}) : super(key: key);

  StakeStore get stakeStore => Get.find<StakeStore>();
  StakeController get controller => Get.find<StakeController>();

  @override
  Widget build(BuildContext context) {
    return stakeStore.when(
      done: (stake) => Column(
        children: [
          rewards(stake),
          const SizedBox(height: 20),
          staked(stake),
          const SizedBox(height: 20),
          hashPower(stake),
          const SizedBox(height: 20),
          hashPowerBonus(stake),
        ],
      )
    );
  }

  Widget hashPower(StakeModel stake) => Column(
    children: [
      Text("Total Hash Power", style: Get.textTheme.bodySmall),
      const SizedBox(height: 8),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset(asset("images/hashpower-fan-center.png"), width: 30, height: 30,),
              Text("${stake.userHashPower}", style: Get.textTheme.headline6),
            ],
          ),
          Text("↑${stake.hashPowerBonus}%",
            style: Get.textTheme.headline6!.copyWith(color: AppPalette.green400),
          ),
          Column(
            children: [
              Text("Base: ${stake.userHashPowerBase}", style: Get.textTheme.bodySmall),
              Text("Bonus: ${stake.userHashPower}", style: Get.textTheme.bodySmall),
            ],
          )
        ],
      )
    ],
  );

  Widget hashPowerBonus(StakeModel stake) => Column(
    children: [
      Text("Hash Power Boost", style: Get.textTheme.bodySmall),
      const SizedBox(height: 8),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset(asset("images/hashpower-fan-center.png"), width: 30, height: 30,),
              Text("+${stake.hashPowerBonus}%", style: Get.textTheme.headline6),
            ],
          ),
          Column(
            children: [
              Text("Next boost (${stake.nextHashPowerBonus}%):", style: Get.textTheme.bodySmall),
              Text("${Number.toCurrency(stake.nextEpwRange)} EPW", style: Get.textTheme.bodySmall),
              Text("Staked", style: Get.textTheme.bodySmall),
            ],
          )
        ],
      )
    ],
  );

  Widget staked(StakeModel stake) => Column(
    children: [
      Text("Total EPW Staked", style: Get.textTheme.bodySmall),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(asset("images/rpw_verde.png"), width: 50, height: 50),
          const SizedBox(width: 10),
          Column(
            children: [
              Text("${Number.toCurrency(stake.userTotalStaked)} EPW",
                style: Get.textTheme.headline6,
              ),
              Text("${stake.eKeyDaily} EKEY/day",
                style: Get.textTheme.bodySmall,
              )
            ],
          )
        ],
      ),
      const SizedBox(height: 10),
      Hero(
        tag: 'stakeEpw',
        child: ElevatedButton(
          child: Text("Unstake EPW"),
          onPressed: () {
            Get.toNamed(AppRoutes.STAKE_EPW, parameters: {
              'unstake': '1',
            });
          },
        ),
      ),
    ],
  );

  Widget rewards(StakeModel stake) => Column(
    children: [
      Text("Available EKEY Rewards", style: Get.textTheme.bodySmall),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(asset("svg/ekey.svg"), height: 60, width: 60,),
          const SizedBox(width: 10),
          Column(
            children: [
              Text("${stake.eKeyToClaim} EKEYS",
                style: Get.textTheme.headline6,
              ),
              Text("1.00 = EKEY unit",
                style: Get.textTheme.bodySmall,
              )
            ],
          )
        ],
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        child: const Text("Claim EKEY"),
        onPressed: stake.eKeyToClaim >= 1
          ? () => controller.claimEkey()
          : null,
      ),
    ],
  );
}
