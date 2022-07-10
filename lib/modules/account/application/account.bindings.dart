import 'package:app/modules/account/application/account.controller.dart';
import 'package:app/stores/user-pods.store.dart';
import 'package:get/get.dart';

class AccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountController());
  }

}