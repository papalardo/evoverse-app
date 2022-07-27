import "package:get/get.dart";

import "package:app/modules/mining/application/mining.controller.dart";

class MiningBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MiningController());
  }

}