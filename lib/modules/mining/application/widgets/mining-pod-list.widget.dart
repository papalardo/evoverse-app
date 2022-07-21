import 'package:app/modules/mining/application/mining.controller.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/stores/mining.store.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/infinite-rotation.widget.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:app/utils/widgets/secondary-list-view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiningPodListWidget extends GetView<MiningController> {
  final MiningStore miningStore;

  const MiningPodListWidget({
    Key? key,
    required this.miningStore,
  }) : super(key: key);

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
      done: (MiningModel mining) => Column(
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
                  Text(Number.toCurrency(mining.energizeCost)),
                ]),
            onPressed: _hasOncePodMining(mining) || mining.pods.isEmpty
                ? null
                : () => _energize(context: context),
          ),
          const SizedBox(height: 10),
          podsListWidget(mining)
        ],
      )
    );
  }

  Widget podsListWidget(MiningModel mining) {
    if (mining.pods.isEmpty) {
      return Column(children: const [
        SizedBox(height: 10),
        Text("No PODs yet", style: TextStyle(fontWeight: FontWeight.bold))
      ]);
    }
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: mining.pods.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.white);
      },
      itemBuilder: (_, idx) {
        var pod = mining.pods[idx];

        return Wrap(
            runSpacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("POD #${pod.id}"),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Text("HP ${Number.toCurrency(pod.totalHashPower)}"),
                      Image.asset('lib/assets/${pod.farming ? 'images-animated/fan.gif' : 'images/fan.png'}',
                        width: 20,
                        height: 20,
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

  _hasOncePodMining(MiningModel mining) {
    return mining.pods.where((pod) => pod.farming).isNotEmpty;
  }

  _energize({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AppDialog.confirm(
          title: "You sure ?",
          message: "It will makes not possible realized some actions about your pods",
          context: context,
          onConfirm: () async {
            Navigator.of(context).pop();
            try {
              await controller.loader.wait(() => controller.energize());
              Toast.show("Pods recharged");
            } on DioError catch (e) {
              Toast.danger("Problem to recharge: ${e.message}");
            }
          }
      )
    );
  }
}
