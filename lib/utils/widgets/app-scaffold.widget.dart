import 'package:app/core/app.routes.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:svg_icon/svg_icon.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  static const List<String> pages = [
    AppRoutes.MINING,
    AppRoutes.STAKE
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.BACKGROUND,
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (pageIdx) => _onChangePage(pageIdx),
        items: [
          BottomNavigationBarItem(
              icon: SvgIcon("lib/assets/icons/mininglab.svg"),
              label: "Mining Lab"
          ),
          BottomNavigationBarItem(
              icon: SvgIcon("lib/assets/icons/staking.svg"),
              label: "Staking"
          ),
        ],
      ),
    );
  }

  _onChangePage(int pageIdx) {
    var route = pages[pageIdx];

    if (route == Get.currentRoute) {
      return;
    }

    Get.offAllNamed(pages[pageIdx]);
  }
}
