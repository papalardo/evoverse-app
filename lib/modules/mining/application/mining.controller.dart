import 'package:app/modules/mining/infra/datasources/mining.datasource.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/stores/mining.store.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:get/get.dart';

class MiningController extends GetxController with LoaderMixin {
  var miningStore = Get.find<MiningStore>();

  @override
  onInit() {
    miningStore.reload();
    super.onInit();
  }

  Future<void> energize() async {
    await MiningDatasource().energize();
    miningStore.reload();
    // await fetchMiningData();
  }

  Future<void> claim() async {
    Toast.show("Not implemented yet");
  }

}