import 'package:get/get.dart';

import 'mining.controller.dart';

class MiningBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MiningController());
  }

}