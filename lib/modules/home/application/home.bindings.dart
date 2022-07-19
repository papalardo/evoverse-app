import 'package:app/modules/account/application/account.bindings.dart';
import 'package:app/modules/mining/application/mining.bindings.dart';
import 'package:app/modules/stake/application/stake.bindings.dart';
import 'package:app/modules/statistics/application/statistics.bindings.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    AccountBindings().dependencies();
    MiningBindings().dependencies();
    StakeBindings().dependencies();
    StatisticsBindings().dependencies();
  }

}