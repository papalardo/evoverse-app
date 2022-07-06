import 'package:get/get.dart';

import 'loader.controller.dart';

class LoaderBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(LoaderController(), permanent: true);
  }
  
}