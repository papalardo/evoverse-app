import 'dart:math';

import 'package:app/core/app.routes.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/loader/loader-wrapper.widget.dart';
import 'package:app/utils/widgets/loader/loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    Key? key,
    required this.body,
    this.floatingActionButton,
    this.appBar,
  }) : super(key: key);

  static const List<String> pages = [
    AppRoutes.ACCOUNT,
    AppRoutes.MINING,
    AppRoutes.STAKE
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppPalette.BACKGROUND,
      floatingActionButton: floatingActionButton,
      body: LoaderWrapperWidget(
        id: 'scaffold',
        child: body,
        loader: const LoaderWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (pageIdx) => _onChangePage(pageIdx),
        currentIndex: max(pages.indexOf(Get.currentRoute), 0),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset("lib/assets/icons/userprofile.svg"),
              label: "Acount"
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("lib/assets/icons/mininglab.svg"),
              label: "Mining Lab"
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("lib/assets/icons/staking.svg"),
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
    
    Get.toNamed(route);
  }
}
