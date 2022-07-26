import 'package:app/modules/raffle/application/raffle.controller.dart';
import 'package:app/modules/raffle/application/stores/raffle-data.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/buttons/tiny.button.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:styled_widget/styled_widget.dart';

class SessionNumberListTile extends StatelessWidget {
  const SessionNumberListTile({Key? key}) : super(key: key);

  RaffleDataStore get store => Get.find<RaffleDataStore>();

  @override
  Widget build(BuildContext context) {
    return store.when(
      busy: () => MainCardItemWidget.shimmer(usingTitle: true),
      done: (state) => MainCardItemWidget(
        icon: SvgPicture.asset(asset("svg/raffle.svg")),
        title: "Raffle number",
        value: "# ${state.id}",
      )
    );
  }

}
