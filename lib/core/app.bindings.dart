import 'package:app/modules/wallet/infra/datasources/wallet.bindings.dart';
import 'package:app/services/http/http.service.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/services/storage/storage.service.dart';
import 'package:app/stores/mining.store.dart';
import 'package:app/stores/stake.store.dart';
import 'package:app/stores/user-accout.store.dart';
import 'package:app/stores/user-pods.store.dart';
import 'package:app/stores/user-workshop.store.dart';
import 'package:app/utils/widgets/loader/loader.bindings.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserPodsStore(), fenix: true);
    Get.lazyPut(() => UserAccountStore(), fenix: true);
    Get.lazyPut(() => UserWorkshopStore(), fenix: true);
    Get.lazyPut(() => MiningStore(), fenix: true);
    Get.lazyPut(() => StakeStore(), fenix: true);

    WalletBindings().dependencies();
  }

  static initServices() async {
    LoaderBindings().dependencies();

    await Get.putAsync<StorageServiceContract>(() async {
      var service = StorageService();
      await service.boot();
      return service;
    }, permanent: true);

    await Get.putAsync<HttpService>(() async {
      var service = HttpService();
      await service.boot();
      return service;
    }, permanent: true);

  }

}