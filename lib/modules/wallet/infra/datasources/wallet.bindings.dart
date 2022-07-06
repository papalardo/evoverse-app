import 'package:app/modules/wallet/application/wallet.controller.dart';
import 'package:get/get.dart';

class WalletBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletController(), permanent: true);
  }

}