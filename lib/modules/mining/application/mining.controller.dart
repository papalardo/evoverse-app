import "package:app/modules/mining/infra/datasources/mining.datasource.dart";
import "package:app/utils/widgets/loader/loader.mixin.dart";
import "package:get/get.dart";

class MiningController extends GetxController with LoaderMixin {
  Future<void> energize() async {
    await MiningDatasource().energize();
  }

  Future<void> claim() async {
    throw "Not available yet";
    await Future.delayed(const Duration(seconds: 2));
  }

}