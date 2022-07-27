import "package:app/modules/stake/infra/datasources/stake.datasource.dart";
import "package:app/stores/stake.store.dart";
import "package:app/utils/toast/toast.dart";
import "package:app/utils/widgets/loader/loader.mixin.dart";
import "package:dio/dio.dart";
import "package:get/get.dart";

class StakeController extends GetxController with LoaderMixin {
  
  StakeStore get stakeStore => Get.find<StakeStore>();
  
  Future<void> claimEkey() async {
    var datasource = StakeDatasource();

    try {
      await loader.wait(() => datasource.claimEkey());
    } on DioError catch (e) {
      Toast.danger(e.message.toString());
      return;
    }


    stakeStore.reload();
  }
}