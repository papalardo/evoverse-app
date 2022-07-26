import 'package:app/modules/account/application/account.view.dart';
import 'package:app/modules/mining/application/mining.view.dart';
import 'package:app/modules/profile/application/profile.view.dart';
import 'package:app/modules/stake/application/stake.view.dart';
import 'package:app/modules/statistics/application/statistics.page.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const double kNormalIcon = 20;

  createTabItem({
    required IconData icon,
    required String label,
  }) {
    return FlashyTabBarItem(
      activeColor: Colors.white,
      inactiveColor: AppPalette.gray300,
      icon: Icon(icon),
      title: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: AppPalette.primary600,
        selectedIndex: _currentIndex,
        showElevation: true,
        iconSize: 24,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          createTabItem(
            icon: Icons.analytics_outlined,
            label: "Pricing"
          ),
          createTabItem(
            icon: Icons.wallet,
            label: "Wallet"
          ),
          createTabItem(
            icon: Icons.memory,
            label: "Mining"
          ),
          createTabItem(
            icon: Icons.savings,
            label: "Staking"
          ),
          createTabItem(
            icon: Icons.menu,
            label: "Menu"
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (index) => setState(() => _currentIndex = index),
      //   currentIndex: _currentIndex,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.analytics_outlined),
      //         label: "Statistics"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgIcon("lib/assets/icons/userprofile.svg"),
      //         label: "Acount"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgIcon("lib/assets/icons/mininglab.svg"),
      //         label: "Mining Lab"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgIcon("lib/assets/icons/staking.svg"),
      //         label: "Staking"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.density_small),
      //         label: "More"
      //     ),
      //   ],
      // ),
    );
  }

  Widget getBody() {
    return LazyLoadIndexedStack(
      index: _currentIndex,
      children: const [
        StatisticsPage(),
        AccountView(),
        MiningView(),
        StakeView(),
        ProfilePage(),
      ],
    );
  }

}
