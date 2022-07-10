import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';
import 'package:app/modules/account/infra/models/player-hash-power.model.dart';
import 'package:app/modules/account/infra/models/pod-count.model.dart';
import 'package:app/modules/account/infra/models/workshop-info.model.dart';
import 'package:app/modules/wallet/application/wallet.controller.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/stores/user-accout.store.dart';
import 'package:app/stores/user-pods.store.dart';
import 'package:app/stores/user-workshop.store.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:get/get.dart';

class AccountController extends GetxController with LoaderMixin {
  final userPodsStore = Get.find<UserPodsStore>();
  final userAccountStore = Get.find<UserAccountStore>();
  final userWorkshopStore = Get.find<UserWorkshopStore>();

  @override
  void onInit() {
    userAccountStore.reload();
    userPodsStore.reload();
    userWorkshopStore.reload();

    super.onInit();
  }

}