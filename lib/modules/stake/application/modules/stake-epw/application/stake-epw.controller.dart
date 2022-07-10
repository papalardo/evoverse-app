import 'package:app/modules/stake/infra/datasources/stake.datasource.dart';
import 'package:app/modules/stake/infra/models/stake-preview.model.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/loader/loader-state.mixin.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class StakeEpwController extends GetxController with LoaderStateMixin {
  final _debounce = Debouncer(delay: const Duration(seconds: 2));
  final _datasource = StakeDatasource();

  var amount = '100'.obs;

  var preview = StakePreviewModel(
    newDailyEkey: 0,
    newHashPowerBonus: 0,
    newStakeTotal: 0,
    newTotalHashPower: 0
  );

  @override
  onInit() {
    fetchPreview();

    super.onInit();
  }

  setAmount(String amount) {
    this.amount(amount);

    _debounce.call(() => fetchPreview());
  }

  Future<void> fetchPreview() async {
    var intAmount = int.tryParse(amount.value);

    if (intAmount == null || intAmount < 100) {
      return;
    }

    try {
      setLoading(true);
      preview = await StakeDatasource().preview(intAmount);
    } finally {
      setLoading(false);
    }
  }

  Future<void> stake() async {
    var intAmount = int.tryParse(amount.value);

    if (intAmount == null || intAmount < 100) {
      Toast.danger("Stake value must be higher than 100.");
      return;
    }

    var loader = Get.find<LoaderController>();

    try {
      loader.setLoading(true);
      await _datasource.stake(intAmount);
      Toast.show("Stake created");

    } on DioError catch (e) {
      Toast.danger(e.message.toString());
    } finally {
      loader.setLoading(false);
    }

  }

}