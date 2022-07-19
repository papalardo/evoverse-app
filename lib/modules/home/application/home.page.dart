import 'package:app/modules/account/application/account.view.dart';
import 'package:app/modules/mining/application/mining.view.dart';
import 'package:app/modules/stake/application/stake.view.dart';
import 'package:app/modules/statistics/application/statistics.page.dart';
import 'package:flutter/material.dart';
import 'package:svg_icon/svg_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: "Statistics"
          ),
          BottomNavigationBarItem(
              icon: SvgIcon("lib/assets/icons/userprofile.svg"),
              label: "Acount"
          ),
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

  Widget getBody() {
    List<Widget> pages = [
      StatisticsPage(),
      AccountView(),
      MiningView(),
      StakeView(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }


}
