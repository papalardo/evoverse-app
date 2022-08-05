import 'package:app/modules/player-keys/application/player-keys.controller.dart';
import 'package:get/get.dart';

class PlayerKeysBindings extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => PlayerKeysController());
  }

}
