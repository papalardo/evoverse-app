import 'package:app/modules/mining/application/mining.controller.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/stores/mining.store.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/infinite-rotation.widget.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/secondary-list-view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiningPodListWidget extends GetView<MiningController> {
  final MiningStore miningStore;

  const MiningPodListWidget({
    Key? key,
    required this.miningStore,
  }) : super(key: key);

  MiningModel? get miningData => miningStore.miningData;

  @override
  Widget build(BuildContext context) {
    return miningStore.when(
      busy: () => ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: false,
        itemCount: 4,
        itemBuilder: (_, __) => MainCardItemWidget.shimmer(),
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(color: Colors.white);
        },
      ),
      done: () => Column(
        children: [
          ElevatedButton(
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                children: [
                  const Text("Recharge all PODs"),
                  const SizedBox(width: 2),
                  Image.asset("lib/assets/images/rpw_verde.png",
                    height: 20,
                    width: 20,
                  ),
                  Text(Number.toCurrency(miningData!.energizeCost)),
                ]),
            onPressed: _hasOncePodMining() || miningData!.pods.isEmpty
                ? null
                : () => _energize(),
          ),
          const SizedBox(height: 10),
          podsListWidget()
        ],
      )
    );
  }

  Widget podsListWidget() {
    if (miningData!.pods.isEmpty) {
      return Column(children: const [
        SizedBox(height: 10),
        Text("No PODs yet", style: TextStyle(fontWeight: FontWeight.bold))
      ]);
    }
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: miningData!.pods.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.white);
      },
      itemBuilder: (_, idx) {
        var pod = miningData!.pods[idx];

        return Wrap(
            runSpacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("POD #${pod.id}"),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 5,
                    children: [
                      Text("HP ${Number.toCurrency(pod.totalHashPower)}"),
                      InfiniteRotationWidget(
                        enable: pod.farming,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppPalette.gray400,
                              borderRadius: BorderRadius.circular(999)
                          ),
                          padding: EdgeInsets.zero,
                          child: Image.asset('lib/assets/images/hashpower-fan-center.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Text(pod.rarity),
            ]);
      },
    );
  }

  _hasOncePodMining() {
    return miningData!.pods.where((pod) => pod.farming).isNotEmpty;
  }

  _energize() {
    Get.defaultDialog(
      title: "You sure ?",
      content: const Text("This action cannot be undone"),
      onConfirm: () {
        controller.loader.wait(() => controller.energize())
          .then((_) => Toast.show("PODs energized"))
          .catchError((e) => Toast.danger(e.toString(), 'Error'));

        Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
      },
      onCancel: () => Navigator.of(Get.overlayContext!, rootNavigator: true).pop(),
      textConfirm: "Yes",
      textCancel: "Cancel"
    );
  }
}
