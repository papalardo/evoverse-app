import 'package:app/stores/stake.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserStakingWidget extends StatelessWidget {
  const UserStakingWidget({Key? key}) : super(key: key);

  StakeStore get stakeStore => Get.find<StakeStore>();

  @override
  Widget build(BuildContext context) {
    return stakeStore.when(
      done: () => Column(
        children: [
          rewards(),
          const SizedBox(height: 20),
          staked(),
          const SizedBox(height: 20),
          hashPower(),
          const SizedBox(height: 20),
          hashPowerBonus(),
        ],
      )
    );
  }

  Widget hashPower() => Column(
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
              Text("${stakeStore.stake!.userHashPower}", style: Get.textTheme.headline6),
            ],
          ),
          Text("↑${stakeStore.stake!.hashPowerBonus}%",
            style: Get.textTheme.headline6!.copyWith(color: AppPalette.green400),
          ),
          Column(
            children: [
              Text("Base: ${stakeStore.stake!.userHashPowerBase}", style: Get.textTheme.bodySmall),
              Text("Bonus: ${stakeStore.stake!.userHashPower}", style: Get.textTheme.bodySmall),
            ],
          )
        ],
      )
    ],
  );

  Widget hashPowerBonus() => Column(
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
              Text("+${stakeStore.stake!.hashPowerBonus}%", style: Get.textTheme.headline6),
            ],
          ),
          Column(
            children: [
              Text("Next boost (${stakeStore.stake!.nextHashPowerBonus}%):", style: Get.textTheme.bodySmall),
              Text("${Number.toCurrency(stakeStore.stake!.nextEpwRange)} EPW", style: Get.textTheme.bodySmall),
              Text("Staked", style: Get.textTheme.bodySmall),
            ],
          )
        ],
      )
    ],
  );

  Widget staked() => Column(
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
              Text("${Number.toCurrency(stakeStore.stake?.userTotalStaked)} EPW",
                style: Get.textTheme.headline6,
              ),
              Text("${stakeStore.stake?.eKeyDaily} EKEY/day",
                style: Get.textTheme.bodySmall,
              )
            ],
          )
        ],
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        child: Text("Unstake EPW"),
        onPressed: () {

        },
      ),
    ],
  );

  Widget rewards() => Column(
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
              Text("${stakeStore.stake?.eKeyDaily} EKEYS",
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
        child: Text("Claim EKEY"),
        onPressed: () {

        },
      ),
    ],
  );
}
