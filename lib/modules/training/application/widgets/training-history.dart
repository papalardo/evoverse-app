import 'package:app/modules/training/application/stores/training.store.dart';
import 'package:app/utils/date.utils.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class TrainingHistory extends StatelessWidget {
  const TrainingHistory({Key? key}) : super(key: key);

  TrainingStore get store => Get.find();

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      title: 'History',
      child: store.when(
        done: (state) => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: state.history.length,
          itemBuilder: (_, idx) {
            var bid = state.history[idx];

            String description = [
              '#${bid.trainingId}',
              bid.trainingType,
              AppDateUtils.toBrDateFormat(bid.date),
              AppDateUtils.toHourFormat(bid.date),
            ].join(" - ");

            return ListTile(
              title: Text("Evo ${bid.evo}"),
              subtitle: Text(description).fontSize(12),
              trailing: Text(bid.rewardAmount == 0
                      ? "DEFEATED"
                      : "${bid.rewardAmount.toInt()} EPW")
                  .textColor(AppPalette.primary900)
                  .fontSize(10)
                  .fontWeight(FontWeight.bold)
                  .paddingDirectional(vertical: 3, horizontal: 5)
                  .backgroundColor(bid.rewardAmount == 0
                      ? AppPalette.orange400
                      : AppPalette.blue400)
                  .clipRRect(all: 5),
            );
          },
        ),
      ),
    );
  }
}
