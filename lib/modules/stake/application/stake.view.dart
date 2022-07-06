import 'package:app/modules/stake/application/stake.controller.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StakeView extends StatelessWidget {
  const StakeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: GetBuilder<StakeController>(
        builder: (controller) {
          return const Text("Stake view");
        },
      ),
    );
  }
}
