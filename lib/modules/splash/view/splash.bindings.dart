import "package:app/modules/splash/view/splash.controller.dart";
import "package:get/get.dart";

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }

}