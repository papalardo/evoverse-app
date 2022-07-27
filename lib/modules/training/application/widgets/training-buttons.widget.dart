import 'package:app/modules/training/application/stores/training.store.dart';
import 'package:app/modules/training/application/training.controller.dart';
import 'package:app/modules/training/infra/models/training.model.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/loader/shimmer-wrapper.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class TrainingButtons extends StatelessWidget {
  const TrainingButtons({Key? key}) : super(key: key);

  Widget trainingButton(TrainingModel training, int index) {
    return Obx(() {
      bool selected = index == TrainingController.to.trainingSelected();
      return ElevatedButton(
        child: Text(training.type).textColor(
          selected ? AppPalette.primary900 : Colors.white,
        ),
        style: ElevatedButton.styleFrom(
          primary: selected ? AppPalette.orange400 : AppPalette.primary900,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppPalette.gray400),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => TrainingController.to.trainingSelected(index),
      );
    });
  }

  Widget shimmerButton() {
    return ShimmerWrapper(
      child: Container(
        height: 35,
        width: 85,
        color: Colors.white,
      ).clipRRect(all: 10),
    );
  }

  Wrap makeWrap({
    required List<Widget> children,
  }) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TrainingStore.to.when(
      busy: () => makeWrap(
        children: List.generate(4, (index) => shimmerButton()),
      ).padding(vertical: 6),
      done: (state) {
        return makeWrap(
          children: state.trainings
              .asMap()
              .map(
                (key, value) => MapEntry(key, trainingButton(value, key)),
              )
              .values
              .toList(),
        );
      },
    );
  }
}
