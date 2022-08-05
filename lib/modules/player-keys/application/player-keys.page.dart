import 'package:app/modules/player-keys/application/player-keys.controller.dart';
import 'package:app/utils/widgets/loader/app-future-builder.widget.dart';
import 'package:flutter/material.dart';

class PlayerKeysPage extends StatelessWidget {
  const PlayerKeysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
      future: PlayerKeysController.to.getKeys(),
      done: (state) => Container()
    );
  }
}
