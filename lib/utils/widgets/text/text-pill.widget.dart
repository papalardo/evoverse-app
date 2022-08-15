import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class TextPill extends StatelessWidget {
  final String text;

  const TextPill(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text)
        .bold()
        .fontSize(10)
        .padding(vertical: 5, horizontal: 10)
        .backgroundColor(AppPalette.primary900)
        .clipRRect(all: 20);
  }
}
