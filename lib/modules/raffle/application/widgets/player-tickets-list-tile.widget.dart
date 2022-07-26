import 'package:app/modules/raffle/application/raffle.controller.dart';
import 'package:app/modules/raffle/application/stores/raffle-data.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/buttons/tiny.button.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

class PlayerTicketsListTile extends StatelessWidget {
  const PlayerTicketsListTile({Key? key}) : super(key: key);

  RaffleDataStore get store => Get.find<RaffleDataStore>();

  RaffleController get controller => Get.find<RaffleController>();

  static const kRaffleSelectRange = [ 1, 5, 10, 20 ];

  @override
  Widget build(BuildContext context) {
    return store.when(
      busy: () => MainCardItemWidget.shimmer(usingTitle: true),
      done: (state) => MainCardItemWidget(
        icon: SvgPicture.asset(asset("svg/raffle.svg")),
        title: "Your tickets",
        child: Flexible(
          child: [
            [
              Text("${state.userTickets}")
                  .textStyle(MainCardItemWidget.valueTextStyle),
              const Text("tickets")
            ].toRow(separator: SizedBox(width: 5)),
            TinyButton(
              child: Text("Buy"),
              onPressed: () => _showModal(context: context)
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        ),
      )
    );
  }

  List<DropdownMenuItem<int>> _buildSelect() {
    return kRaffleSelectRange
      .map((val) {
        return DropdownMenuItem(
          value: val,
          child: Text("$val tickets").textColor(Colors.white),
        );
      })
      .toList();
  }


  _showModal({
    required BuildContext context
  }) {
    showDialog(
      context: context,
      builder: (_context) {
        return AppDialog(
          icon: SvgPicture.asset(asset("svg/raffle.svg"), width: 100),
          child: [
            store.when(
                done: (state) => Text("${state.ticketPrice} ${state.ticketCurrency}/ticket")
            ),
            store.when(
                done: (state) => Obx(() {
                  return Text("${controller.buyAmount() * state.ticketPrice} ${state.ticketCurrency}/total");
                })
            ),
            Divider(),
            Obx(() => DropdownButton<int>(
                onChanged: (v) => controller.buyAmount(v ?? 1),
                value: controller.buyAmount(),
                items: _buildSelect(),
                hint: Text("${controller.buyAmount()} tickets")
                    .paddingSymmetric(horizontal: 10, vertical: 5)
                    .backgroundColor(AppPalette.gray300)
                    .clipRRect(all: 10)
                    .elevation(5)
            )),
            ElevatedButton(
              child: Text("Buy"),
              onPressed: () {
                Navigator.of(_context).pop();
                var globalLoader = Get.find<LoaderController>();
                globalLoader
                  .wait(() => controller.buyTicket(), 'scaffold')
                  .then((_) => store.reload());
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
