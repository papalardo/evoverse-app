import 'package:get/get.dart';

import 'auth.controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }

}