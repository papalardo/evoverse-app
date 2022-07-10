import 'package:app/modules/stake/application/modules/stake-epw/application/stake-epw.controller.dart';
import 'package:get/get.dart';

class StakeEpwBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StakeEpwController());
  }

}