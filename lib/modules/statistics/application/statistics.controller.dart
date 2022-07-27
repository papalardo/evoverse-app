import "package:app/modules/statistics/infra/datasources/statistics.datasource.dart";
import "package:app/modules/statistics/infra/models/token.model.dart";
import "package:app/utils/widgets/loader/loader-state.mixin.dart";
import "package:get/get.dart";

class StatisticsController extends GetxController with LoaderStateMixin {
  TokenModel? epw;
  TokenModel? evs;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  fetch() async {
    try {
      setLoading(true);
      epw = await StatisticsDatasource().epw();
      evs = await StatisticsDatasource().evs();

    } finally {
      setLoading(false);
    }
  }

}