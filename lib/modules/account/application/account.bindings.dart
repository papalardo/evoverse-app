import "package:app/modules/account/application/account.controller.dart";
import "package:get/get.dart";

class AccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
  }

}