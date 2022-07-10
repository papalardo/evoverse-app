import 'package:app/modules/stake/application/stake.controller.dart';
import 'package:get/get.dart';

class StakeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StakeController());
  }

}