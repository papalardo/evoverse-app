import 'package:app/exceptions/http-exception.dart';
import 'package:app/modules/player-keys/application/player-keys.controller.dart';
import 'package:app/modules/player-keys/infra/models/player-key.model.dart';
import 'package:app/modules/statistics/application/stores/epw_statistics.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/logger.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/loader/shimmer-wrapper.widget.dart';
import 'package:app/utils/widgets/text/text-pill.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

class PlayerKeyForSaleListTile extends StatelessWidget {
  final PlayerKeyModel playerKey;

  const PlayerKeyForSaleListTile({
    Key? key,
    required this.playerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openOptions(
        context: context,
        playerKey: playerKey,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppPalette.gray400, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        color: AppPalette.primary400,
        child: [
          [
            SvgPicture.asset(
              asset("svg/ekey.svg"),
              width: 60,
              height: 60,
            ),
            TextPill("EKEY#${playerKey.id}"),
          ].toColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            separator: const SizedBox(height: 5),
          ),
          Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 3,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                children: [
                  SvgPicture.asset(asset("svg/busd.svg"),
                      width: 15, height: 15),
                  Text("\$${Number.toCurrency(playerKey.sellingPrice)}").bold()
                ],
              ),
              Text("\$${Number.toCurrency(playerKey.sellingPrice! * 0.9)}")
                  .bold()
                  .fontSize(12)
                  .textColor(AppPalette.green400),
              EpwStatisticsStore.to.when(
                busy: () => ShimmerWrapper(
                  child: Container(width: 35, height: 10, color: Colors.white),
                ),
                done: (token) => Text(
                  "${(playerKey.sellingPrice! / double.parse(token.price)).toStringAsFixed(2)} "
                  "${token.symbol}",
                ).fontSize(10),
              ),
            ],
          ),
        ]
            .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .padding(all: 10),
      ),
    );
  }

  void openOptions({
    required BuildContext context,
    required PlayerKeyModel playerKey,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AppDialog(
          icon: SvgPicture.asset(asset("svg/ekey.svg")),
          child: [
            TextPill("EKEY#${playerKey.id}"),
            ElevatedButton(
              child: Text("Remove from marketplace"),
              onPressed: () => removeFromMarket(
                context: dialogContext,
                playerKey: playerKey,
              ),
            )
          ].toColumn(
            mainAxisSize: MainAxisSize.min,
            separator: const SizedBox(height: 5),
          ),
        );
      },
    );
  }

  void removeFromMarket({
    required BuildContext context,
    required PlayerKeyModel playerKey,
  }) async {
    Navigator.of(context).pop();
    try {
      await LoaderController.to.wait(
        () => PlayerKeysController.to.removeFromSale(playerKey.id),
      );
    } on AppHttpException catch (err) {
      Toast.danger(err.message);
    }
  }
}
