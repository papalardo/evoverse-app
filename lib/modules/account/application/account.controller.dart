import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';
import 'package:app/modules/account/infra/models/pod-count.model.dart';
import 'package:app/modules/account/infra/models/workshop-info.model.dart';
import 'package:app/modules/wallet/application/wallet.controller.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:get/get.dart';

class AccountController extends GetxController with LoaderMixin {
  final _storageClient = Get.find<StorageServiceContract>();

  AccountModel? account;
  WorkshopInfoModel? workshop;
  List<PodCount> pods = [];

  String? walletAddress;

  @override
  void onReady() {
    var future = Future.wait([
      fetch(),
      fetchWorkshopInfo(),
      fetchPods(),
    ]);

    loader.showWhile(() => future);

    super.onReady();
  }

  Future<void> fetch() async {
    walletAddress = await _storageClient.get<String>('walletAddress');
    account = await AccountDatasource().fetch(walletAddress!);
    update();
  }

  Future<void> fetchWorkshopInfo() async {
    workshop = await AccountDatasource().workshopInfo();
    update();
  }

  Future<void> fetchPods() async {
    pods = await AccountDatasource().getAccountPods();

    update();
  }

}