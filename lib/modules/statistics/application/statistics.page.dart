import 'package:app/modules/statistics/infra/models/token.model.dart';
import 'package:app/stores/stake.store.dart';
import 'package:app/stores/user-accout.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/widgets/conditional.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'statistics.controller.dart';
import 'widgets/statistic-card.widget.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  StatisticsController get c => Get.find<StatisticsController>();
  UserAccountStore get accountStore => Get.find<UserAccountStore>();
  StakeStore get stakeStore => Get.find<StakeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => c.fetch(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<StatisticsController>(
                builder: (_) {
                  return GridView(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      mainAxisExtent: 100,
                    ),
                    children: Conditional.fn(c.isLoading(),
                      onTrue: () => List.generate(6, (index) => StatisticCard.shimmer()),
                      onFalse: () => [
                        StatisticCard(
                          title: c.epw!.symbol,
                          text1: "\$ ${c.epw!.price}",
                          image: c.epw!.image,
                        ),
                        card(c.epw!),
                        card(c.evs!),
                        accountStore.when(
                            done: () => userData(c.epw!, "EPW to Withdraw", accountStore.account!.epw)
                        ),
                        accountStore.when(
                            done: () => userData(c.epw!, "EPW to Claim", accountStore.account!.epwToClaim)
                        ),
                        accountStore.when(
                            done: () => userData(c.epw!, "EPW Staked", accountStore.account!.epwStaked)
                        ),
                        accountStore.when(
                            done: () => userData(c.epw!, "Total EPW in Game", accountStore.account!.epw
                                + accountStore.account!.epwStaked
                                + accountStore.account!.epwToClaim)
                        ),
                        // userData(c.epw!)
                      ]
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget card(TokenModel token) {
    return [
      [
        Text(token.symbol, style: Get.textTheme.headline6),
        Text("\$ ${token.price}"),
      ].toColumn(
        separator: const SizedBox(height: 5),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      Image.asset(asset(token.image), width: 30, height: 30),
    ]
      .toRow(
        separator: const SizedBox(width: 10),
        mainAxisAlignment: MainAxisAlignment.spaceBetween
      )
      .padding(vertical: 10, horizontal: 15)
      .borderRadius(all: 30)
      .backgroundColor(const Color(0xFF272f3b));
  }

  Widget userData(TokenModel token, String title, num value) {
    return [
      [
        Text(title, style: Get.textTheme.bodySmall),
        Text("${Number.toCurrency(value)} ${token.symbol}"),
        Text("\$ ${Number.toCurrency(double.tryParse(token.price)! * value, 4)}"),
      ].toColumn(
        separator: const SizedBox(height: 5),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      Image.asset(asset(token.image), width: 30, height: 30),
    ]
        .toRow(
        separator: const SizedBox(width: 10),
        mainAxisAlignment: MainAxisAlignment.spaceBetween
    )
        .padding(vertical: 10, horizontal: 15)
        .borderRadius(all: 30)
        .backgroundColor(const Color(0xFF272f3b));
  }

}
