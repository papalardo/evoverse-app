import "package:app/modules/statistics/infra/models/token.model.dart";
import "package:app/stores/stake.store.dart";
import "package:app/stores/user-accout.store.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/number.dart";
import "package:app/utils/widgets/conditional.widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:styled_widget/styled_widget.dart";

import "package:app/modules/statistics/application/statistics.controller.dart";
import "package:app/modules/statistics/application/widgets/statistic-card.widget.dart";

class StatisticsPage extends GetView<StatisticsController> {
  const StatisticsPage({Key? key}) : super(key: key);

  UserAccountStore get accountStore => Get.find<UserAccountStore>();
  StakeStore get stakeStore => Get.find<StakeStore>();

  refresh() {
    controller.fetch();
    accountStore.reload();
    stakeStore.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => refresh(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<StatisticsController>(
                builder: (_) {
                  return accountStore.when(
                    busy: () => GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 100,
                      ),
                      children: List.generate(6, (index) => StatisticCard.shimmer()),
                    ),
                    done: (account) => GetBuilder<StatisticsController>(
                      builder: (_) => GridView(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 100,
                        ),
                        children: Conditional.fn(controller.isLoading(),
                            onTrue: () => List.generate(6, (index) => StatisticCard.shimmer()),
                            onFalse: () => [
                              StatisticCard(
                                title: controller.epw!.symbol,
                                text1: "\$ ${controller.epw!.price}",
                                image: controller.epw!.image,
                              ),
                              card(controller.epw!),
                              card(controller.evs!),
                              userData(controller.epw!, "EPW to Withdraw", account.epw),
                              userData(controller.epw!, "EPW Staked", account.epwStaked),
                              userData(controller.epw!, "Total EPW in Game", account.epw
                                  + account.epwStaked
                                  + account.epwToClaim),
                            ]
                        ),
                      )
                    )
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
      .card(color: const Color(0xFF272f3b));
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
    ] .toRow(
      separator: const SizedBox(width: 10),
      mainAxisAlignment: MainAxisAlignment.spaceBetween
    ) .padding(vertical: 10, horizontal: 15)
      .card(color: const Color(0xFF272f3b));
  }

}
