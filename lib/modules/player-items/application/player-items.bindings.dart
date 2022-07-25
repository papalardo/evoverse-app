import 'package:get/get.dart';

import 'player-items.controller.dart';

class PlayerItemsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayerItemsController());
  }

}