import 'package:app/modules/stake/application/stake.controller.dart';
import 'package:app/modules/stake/application/widgets/new-stake.widget.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/user-staking.widget.dart';

class StakeView extends StatelessWidget {
  const StakeView({Key? key}) : super(key: key);

  static const kPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ListView(
        padding: EdgeInsets.only(
            top: Get.mediaQuery.padding.top + kPadding,
            bottom: kPadding,
            left: kPadding,
            right: kPadding
        ),
        children: [
          MainCardWidget(
            title: "New stake",
            child: NewStakeWidget(),
          ),
          const SizedBox(height: 8),
          MainCardWidget(
            title: "Your Staking",
            child: UserStakingWidget(),
          ),
        ],
      ),
    );
  }
}
