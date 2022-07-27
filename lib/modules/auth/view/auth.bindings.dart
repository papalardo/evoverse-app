import "package:get/get.dart";

import "package:app/modules/auth/view/auth.controller.dart";

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }

}