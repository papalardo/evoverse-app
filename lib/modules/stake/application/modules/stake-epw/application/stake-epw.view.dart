import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'stake-epw.controller.dart';

class StakeEpwView extends StatelessWidget {
  const StakeEpwView({Key? key}) : super(key: key);

  StakeEpwController get controller => Get.find<StakeEpwController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 30,
          ),
          child: Column(
            children: [
              Text("Add EPW to Stake", style: Get.textTheme.headline6),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Amount'),
                  helperText: "min: 100"
                ),
                onChanged: (v) => controller.setAmount(v),
                initialValue: controller.amount.value,
              ),
              const SizedBox(height: 20),
              Text("Preview"),
              GetBuilder<StakeEpwController>(
                builder: (_) {
                  if (controller.isLoading()) {
                    return CircularProgressIndicator();
                  }
                  var preview = controller.preview;
                  return Column(
                    children: [
                      Text("New stake total ${preview.newStakeTotal}"),
                      Text("Total hash power ${preview.newTotalHashPower}"),
                      Text("${preview.newDailyEkey} EKEY/day"),
                      Text("↑${preview.newHashPowerBonus}%"),
                    ],
                  );
                }
              ),
              ElevatedButton(
                onPressed: () => controller.stake(),
                child: Text("Confirm")
              )
            ],
          ),
        ),
      ),
    );
  }
}
