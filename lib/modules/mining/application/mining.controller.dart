import 'package:app/modules/mining/infra/datasources/mining.datasource.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:get/get.dart';

class MiningController extends GetxController with LoaderMixin {
  MiningModel? miningData;

  @override
  void onReady() {
    loader.wait(() => fetchMiningData(), 'scaffold');

    super.onReady();
  }

  Future<void> fetchMiningData() async {
    miningData = await MiningDatasource().fetch();
    update();
  }

  Future<void> energize() async {
    await MiningDatasource().energize();
    await fetchMiningData();
  }

  Future<void> claim() async {
    Toast.show("Not implemented yet");
  }

}