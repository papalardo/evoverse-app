import 'package:app/modules/stake/infra/datasources/stake.datasource.dart';
import 'package:app/modules/stake/infra/models/stake-preview.model.dart';
import 'package:app/utils/logger.dart';
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

  var amount = '100';

  var unstakeMode = false;

  var preview = StakePreviewModel(
    newDailyEkey: 0,
    newHashPowerBonus: 0,
    newStakeTotal: 0,
    newTotalHashPower: 0
  );

  @override
  onInit() {
    unstakeMode = Get.parameters.containsKey('unstake');

    fetchPreview();

    super.onInit();
  }

  setAmount(String amount) {
    this.amount = amount;
    setLoading(true);

    _debounce.call(() => fetchPreview());
  }

  bool _validAmount() {
    var intAmount = int.tryParse(amount);

    if (intAmount == null) return false;

    if (intAmount < 100) return false;

    return true;
  }

  Future<void> fetchPreview() async {
    if (! _validAmount()) {
      setLoading(false);
      return;
    }

    var intAmount = int.parse(amount);

    setLoading(true);

    try {
      preview = await StakeDatasource().preview(
        unstakeMode ? -intAmount : intAmount
      );
    } on DioError catch (e) {
      Toast.danger(e.message.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> stake() async {
    if (! _validAmount()) {
      Toast.danger(unstakeMode
          ? "Unstake value must be higher than 100"
          : "Stake value must be higher than 100");
      return;
    }

    var intAmount = int.parse(amount);

    var loader = Get.find<LoaderController>();

    try {
      loader.setLoading(true);
      if (unstakeMode) {
        await _datasource.unstake(intAmount);
      } else {
        await _datasource.stake(intAmount);
      }

      Get.back();

      Toast.show(unstakeMode
        ? "Unstaked successfully"
        : "Staked successfully");

    } on DioError catch (e) {
      Toast.danger(e.message.toString());
    } finally {
      loader.setLoading(false);
    }

  }

}