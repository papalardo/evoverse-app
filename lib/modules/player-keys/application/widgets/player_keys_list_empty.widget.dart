import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class PlayerKeysListEmpty extends StatelessWidget {
  const PlayerKeysListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("KEYS NOT FOUND")
      .fontSize(14)
      .textAlignment(TextAlign.center)
      .bold()
      .padding(vertical: 15);
  }
}
