import 'package:app/modules/wallet/infra/datasources/wallet.bindings.dart';
import 'package:app/services/http/http.service.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/services/storage/storage.service.dart';
import 'package:app/utils/widgets/loader/loader.bindings.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
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