import "package:app/modules/stake/application/widgets/new-stake.widget.dart";
import "package:app/utils/widgets/app-scaffold.widget.dart";
import "package:app/utils/widgets/main-card.widget.dart";
import "package:flutter/material.dart";

import "package:app/modules/stake/application/widgets/user-staking.widget.dart";

class StakeView extends StatelessWidget {
  const StakeView({Key? key}) : super(key: key);

  static const kPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(kPadding),
          children: const [
            MainCardWidget(
              title: "New stake",
              child: NewStakeWidget(),
            ),
            SizedBox(height: 8),
            MainCardWidget(
              title: "Your Staking",
              child: UserStakingWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
