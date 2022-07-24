import 'package:app/exceptions/http-exception.dart';
import 'package:app/modules/account/infra/models/mint-pod.model.dart';
import 'package:app/modules/account/infra/models/workshop-info.model.dart';
import 'package:app/stores/user-workshop.store.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/buttons/tiny.button.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/dialog/mint-pod-result.dialog.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/loader/shimmer-wrapper.widget.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

abstract class MintableListTile extends StatelessWidget {
  final String confirmationMessage;
  final String assetTitle;

  const MintableListTile({
    Key? key,
    required this.confirmationMessage,
    required this.assetTitle,
  }) : super(key: key);


  UserWorkshopStore get userWorkshopStore => Get.find<UserWorkshopStore>();

  bool get canUse => assetCount > 0;

  int get assetCount;

  Widget get assetImage;

  @override
  Widget build(BuildContext context) {
    return userWorkshopStore.when(
      busy: () => loader(),
      done: (WorkshopInfoModel workshop) => MainCardItemWidget(
        title: assetTitle,
        icon: assetImage,
        child: Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(assetCount.toString(), style: MainCardItemWidget.valueTextStyle),
              TinyButton(
                child: const Text("Open"),
                onPressed: canUse
                    ? () => showConfirmationDialog(context: context)
                    : null,
              )
            ],
          ),
        ),
      )
    );
  }

  Widget loader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      MainCardItemWidget.shimmer(usingTitle: true),
      ShimmerWrapper(
        child: const SizedBox(width: 55, height: 30)
          .backgroundColor(Colors.white)
          .clipRRect(all: 20),
      )
    ],
  );

  showConfirmationDialog({
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (_context) => AppDialog.confirm(
        context: _context,
        title: confirmationMessage,
        icon: assetImage,
        onConfirm: () async {
          Navigator.of(_context).pop();
          onConfirm(context: context);
        },
      )
    );
  }

  Future<MintPodModel> mint();

  onConfirm({
    required BuildContext context,
  }) async {
    var loader = Get.find<LoaderController>();
    late MintPodModel pod;
    try {
      pod = await loader.wait(() => mint());
    } on AppHttpException catch (err) {
      return Toast.danger(err.message);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_context) => MintPodResultDialog(
        pod: pod,
        onClose: () {
          Navigator.of(_context).pop();
          userWorkshopStore.reload();
        },
        onRepeat: () {
          Navigator.of(_context).pop();
          onConfirm(context: context);
        },
      )
    );
  }
}
