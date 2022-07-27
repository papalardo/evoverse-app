import 'package:app/modules/training/application/widgets/training-buttons.widget.dart';
import 'package:app/modules/training/application/widgets/training-card.widget.dart';
import 'package:app/modules/training/application/widgets/training-history.dart';
import 'package:app/modules/training/application/widgets/training-times.widget.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import "package:app/modules/training/application/stores/training.store.dart";

import 'package:app/modules/training/application/training.controller.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("TRAINING"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => TrainingStore.to.reload(),
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              const TrainingButtons(),
              const SizedBox(height: 10),
              const TrainingTimesWidget(),
              const SizedBox(height: 10),
              TrainingStore.to.when(
                done: (state) => Obx(
                  () => LazyLoadIndexedStack(
                    index: TrainingController.to.trainingSelected(),
                    children: state.trainings
                        .asMap()
                        .map((key, value) {
                          return MapEntry(key, TrainingCard(index: key));
                        })
                        .values
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const TrainingHistory()
            ],
          ),
        ),
      ),
    );
  }
}
