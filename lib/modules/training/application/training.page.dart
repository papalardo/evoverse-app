import 'package:app/modules/training/application/widgets/training-card.widget.dart';
import 'package:app/modules/training/infra/models/training.model.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:app/utils/widgets/text/date-countdown.widget.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import "package:get/instance_manager.dart";

import "package:app/modules/training/application/stores/training.store.dart";

import 'package:app/modules/training/application/training.controller.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:styled_widget/styled_widget.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({Key? key}) : super(key: key);

  TrainingStore get store => Get.find();

  TrainingController get controller => Get.find();

  Widget trainingButton(TrainingModel training, int index) {
    return Obx(() {
      bool selected = index == controller.trainingSelected();
      return ElevatedButton(
        child: Text(training.type)
            .textColor(selected ? AppPalette.primary900 : Colors.white),
        style: ElevatedButton.styleFrom(
          primary: selected ? AppPalette.orange400 : AppPalette.primary900,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppPalette.gray400),
              borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () => controller.trainingSelected(index),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("TRAINING"),
      ),
      body: SafeArea(
        child: store.when(
          done: (state) => ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Wrap(
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.center,
                children: state.trainings
                    .asMap()
                    .map((key, value) =>
                        MapEntry(key, trainingButton(value, key)))
                    .values
                    .toList(),
              ),
              const SizedBox(height: 10),
              Obx(() {
                return LazyLoadIndexedStack(
                  index: controller.trainingSelected(),
                  children: state.trainings
                      .asMap()
                      .map((key, value) {
                        return MapEntry(key, TrainingCard(index: key));
                      })
                      .values
                      .toList()
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

}
