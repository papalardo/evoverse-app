import 'package:app/modules/player-keys/infra/models/player-key.model.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

class PlayerKeyListTile extends StatelessWidget {
  final PlayerKeyModel playerKey;

  const PlayerKeyListTile({
    Key? key,
    required this.playerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppPalette.gray400, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppPalette.primary400,
      child: [
        SvgPicture.asset(asset("svg/ekey.svg")),
        Text("EKEY#${playerKey.id}")
            .bold()
            .padding(vertical: 5, horizontal: 10)
            .backgroundColor(AppPalette.primary900)
            .clipRRect(all: 20)
      ].toColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        separator: const SizedBox(height: 5),
      ),
    );
  }
}
