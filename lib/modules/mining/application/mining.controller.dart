import 'package:app/modules/mining/infra/datasources/mining.datasource.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:get/get.dart';

class MiningController extends GetxController with LoaderMixin {
  MiningModel? miningData;

  @override
  void onReady() {
    fetch();

    super.onReady();
  }

  Future<void> fetch() async {
    loader.show();

    try {
      miningData = await MiningDatasource().fetch();
    } finally {
      loader.hide();
    }

    update();
  }

  Future<void> energize() async {
    try {
      loader.show();

      await MiningDatasource().energize();
      Toast.show("PODs energized");
      miningData = await MiningDatasource().fetch();
    } catch (e) {
      print("eee ==> $e");
      Toast.danger(e.toString(), 'Error');
    } finally {
      loader.hide();
    }
  }

  Future<void> claim() async {
    Toast.show("Not implemented yet");
  }

}