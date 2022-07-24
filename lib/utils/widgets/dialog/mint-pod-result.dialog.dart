import 'package:app/modules/account/infra/models/mint-pod.model.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class MintPodResultDialog extends StatelessWidget {
  final MintPodModel pod;
  final Function() onClose;
  final Function() onRepeat;

  const MintPodResultDialog({
    Key? key,
    required this.pod,
    required this.onClose,
    required this.onRepeat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDialog(
        disableCloseButton: true,
        child: [
          Text("Congratulations"),
          Text("You've got a new POD"),
          Image.asset(asset("images/pod-rarities/${pod.rarity.toLowerCase()}.png"),
            width: 150,
            height: 150,
          ),
          Text("POD #${pod.podId}")
              .fontWeight(FontWeight.bold),
          Text(pod.rarity)
              .textColor(AppPalette.byRarity(pod.rarity))
              .fontWeight(FontWeight.bold),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              Image.asset(asset('images/fan.png'), width: 15, height: 15),
              Text(pod.hashPower.toString())
            ],
          ),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                  onPressed: onClose,
                  child: Text("OK")
              ),
              ElevatedButton(
                  onPressed: onRepeat,
                  child: Text("Open New")
              )
            ],
          )
        ].toColumn(
          mainAxisSize: MainAxisSize.min,
          separator: const SizedBox(height: 5),
        )
    );
  }
}
