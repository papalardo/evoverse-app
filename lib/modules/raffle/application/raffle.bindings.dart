import 'package:app/modules/raffle/application/raffle.controller.dart';
import 'package:app/modules/raffle/application/stores/raffle-data.store.dart';
import 'package:get/get.dart';

class RaffleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RaffleController());
    Get.lazyPut(() => RaffleDataStore(), fenix: true);
  }

}