import 'package:app/modules/training/application/stores/training.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:app/utils/widgets/text/date-countdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class TrainingTimesWidget extends StatelessWidget {
  const TrainingTimesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      title: "Ending soon",
      child: TrainingStore.to.when(
        busy: () => List.generate(4, (index) {
          return MainCardItemWidget.shimmer(usingTitle: true);
        }).toColumn(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            separator: const SizedBox(height: 5)
        ),
        done: (state) => state.trainings
            .map((training) {
              return MainCardItemWidget(
                icon: Image.asset(asset("images-animated/hourglass.gif")),
                title: "${training.type} #${training.id}",
                child: Flexible(
                  child: DateCountdownWidget(
                    timezone: DateCountDownTimezones.br,
                    endsAt: training.startsAt.add(
                      Duration(seconds: state.duration),
                    ),
                  ),
                ),
              );
            })
            .toList()
            .toColumn(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              separator: const SizedBox(height: 5)
            ),
      ),
    );
  }
}
