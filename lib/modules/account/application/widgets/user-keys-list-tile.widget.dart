import 'package:app/core/app.routes.dart';
import 'package:app/modules/player-keys/application/stores/player-keys.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/widgets/buttons/tiny.button.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserKeysListTile extends StatelessWidget {
  const UserKeysListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayerKeysStore.to.when(
      done: (state) => MainCardItemWidget(
        title: "Keys",
        icon: SvgPicture.asset(asset("svg/ekey.svg")),
        value: state.length.toString(),
        child: Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: TinyButton(
              child: Text("See more"),
              onPressed: () => Get.toNamed(AppRoutes.playerKeys),
            ),
          ),
        ),
      )
    );
  }
}
