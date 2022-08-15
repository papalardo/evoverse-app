import 'package:app/exceptions/http-exception.dart';
import 'package:app/modules/account/infra/models/mint-pod.model.dart';
import 'package:app/modules/player-keys/application/player-keys.controller.dart';
import 'package:app/modules/player-keys/application/stores/player-keys.store.dart';
import 'package:app/modules/player-keys/application/widgets/player_for_sale_keys_list.widget.dart';
import 'package:app/modules/player-keys/application/widgets/player_key_for_sale_list_tile.widget.dart';
import 'package:app/modules/player-keys/application/widgets/player_key_list_tile.widget.dart';
import 'package:app/modules/player-keys/application/widgets/player_wallet_keys_list.widget.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/app-scaffold.widget.dart';
import 'package:app/utils/widgets/buttons/group_buttons.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/dialog/mint-pod-result.dialog.dart';
import 'package:app/utils/widgets/loader/app-future-builder.widget.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:styled_widget/styled_widget.dart';

class PlayerKeysPage extends StatelessWidget {
  const PlayerKeysPage({Key? key}) : super(key: key);

  PlayerKeysController get controller => PlayerKeysController.to;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("KEYS"),
      ),
      floatingActionButton: PlayerKeysStore.to.when(done: (state) {
        return Obx(() {
          if (controller.selectedIndex() == controller.buttonAvailableIndex) {
            var list = controller.filterKeys(state).toList();
            if (list.isNotEmpty) {
              return FloatingActionButton.extended(
                onPressed: () => showConfirmationDialog(context: context),
                label: Text("OPEN KEY"),
              );
            }
          }
          return const SizedBox();
        });
      }),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: GroupButtons(
                initialSelected: controller.selectedIndex(),
                onChange: (int idx) => controller.selectedIndex(idx),
                buttons: [
                  GroupButtonsItem(
                    child: Text("AVAILABLE"),
                    value: controller.buttonAvailableIndex,
                  ),
                  GroupButtonsItem(
                    child: Text("FOR SALE"),
                    value: controller.buttonForSaleIndex,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return const [
                  PlayerWalletKeysList(),
                  PlayerForSaleKeysList()
                ][controller.selectedIndex()];
              }),
            )
          ],
        ),
      ),
    );
  }

  Future refresh() {
    return Future.wait([PlayerKeysStore.to.reload()]);
  }

  showConfirmationDialog({
    required BuildContext context,
  }) async {
    showDialog(
        context: context,
        builder: (_context) => AppDialog.confirm(
              context: _context,
              title: "Confirm to open ekey",
              icon: SvgPicture.asset(asset("svg/ekey.svg")),
              onConfirm: () async {
                Navigator.of(_context).pop();
                onConfirm(context: context);
              },
            ));
  }

  onConfirm({
    required BuildContext context,
  }) async {
    late MintPodModel pod;
    try {
      pod = await LoaderController.to.wait(() async {});
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
                refresh();
              },
              onRepeat: () {
                Navigator.of(_context).pop();
                onConfirm(context: context);
              },
            ));
  }
}
