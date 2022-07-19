import 'package:app/modules/statistics/application/statistics.controller.dart';
import 'package:get/get.dart';

class StatisticsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticsController());
  }

}