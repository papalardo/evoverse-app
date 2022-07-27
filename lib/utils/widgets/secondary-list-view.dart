import "package:flutter/material.dart";

class SecondaryListView extends StatelessWidget {
  final List<Widget> children;
  final double? itemExtent;

  const SecondaryListView({
    Key? key,
    required this.children,
    this.itemExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: false,
      itemExtent: itemExtent,
      children: children,
    );
  }
}
