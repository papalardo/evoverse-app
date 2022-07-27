import "package:get/get.dart";

import "package:app/utils/widgets/loader/loader.controller.dart";

class LoaderBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(LoaderController(), permanent: true);
  }
  
}