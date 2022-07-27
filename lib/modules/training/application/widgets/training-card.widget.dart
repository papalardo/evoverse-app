import 'package:app/modules/training/application/stores/training.store.dart';
import 'package:app/modules/training/application/training.controller.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/main-card.widget.dart';
import 'package:app/utils/widgets/text/date-countdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

class TrainingCard extends StatelessWidget {
  final int index;

  const TrainingCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  TrainingStore get store => Get.find();

  TrainingController get controller => Get.find();

  @override
  Widget build(BuildContext context) {
    return store.when(
      done: (state) {
        var training = state.trainings[index];
        return MainCardWidget(
          title: "${training.type} Training #${training.id}",
          child: Column(
            children: [
              MainCardItemWidget(
                icon: Image.asset(
                  asset("images-animated/hourglass.gif"),
                ),
                child: DateCountdownWidget(
                  timezone: DateCountDownTimezones.br,
                  endsAt: training.startsAt.add(
                    Duration(seconds: state.duration),
                  ),
                  onOver: () => store.reload(),
                ),
              ),
              const Divider(),
              Wrap(
                direction: Axis.vertical,
                spacing: 15,
                children: training.evos.map((evo) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        child: Text("Recharge: EVO ${evo}"),
                        onPressed: () {
                          showConfirmRecharge(
                            context: context,
                            evo: evo,
                          );
                        },
                      ),
                      Text("Recharged: 0 epw"),
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        );
      }
    );
  }


  static const kSelectRange = [1, 3, 5, 10, 25, 50];

  List<DropdownMenuItem<int>> _buildSelect() {
    return kSelectRange.map((val) {
      return DropdownMenuItem(
        value: val,
        child: Text("$val tickets").textColor(Colors.white),
      );
    }).toList();
  }

  showConfirmRecharge({
    required BuildContext context,
    required String evo,
  }) {
    showDialog(
        context: context,
        builder: (_context) {
          return AppDialog(
              child: [
                Text("Recharge evo ${evo}"),
                store.when(
                  done: (state) => Text(
                    "${state.bidCost} ${state.bidCurrency}/ticket",
                  ),
                ),
                store.when(
                  done: (state) => Obx(() {
                    return Text(
                      "${controller.buyAmount() * state.bidCost} ${state.bidCurrency}/total",
                    );
                  }),
                ),
                const Divider(),
                Obx(() {
                  return DropdownButton<int>(
                    onChanged: (v) => controller.buyAmount(v ?? 1),
                    value: controller.buyAmount(),
                    items: _buildSelect(),
                    hint: Text("${controller.buyAmount()} tickets")
                        .paddingSymmetric(horizontal: 10, vertical: 5)
                        .backgroundColor(AppPalette.gray300)
                        .clipRRect(all: 10)
                        .elevation(5),
                  );
                }),
                ElevatedButton(
                  child: const Text("Buy"),
                  onPressed: () {
                    Navigator.of(_context).pop();
                    var globalLoader = Get.find<LoaderController>();
                    globalLoader
                        .wait(() => controller.bidTraining(evo), "scaffold")
                        .then((_) => store.reload())
                        .catchError((_) {});
                  },
                )
              ].toColumn(
                mainAxisSize: MainAxisSize.min,
                separator: const SizedBox(height: 5),
              )
          );
        }
    );
  }
}
