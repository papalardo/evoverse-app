import "package:get/get.dart";

import "package:app/modules/player-items/application/player-items.controller.dart";

class PlayerItemsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayerItemsController());
  }

}