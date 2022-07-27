import 'package:app/modules/training/application/stores/training.store.dart';
import 'package:app/modules/training/application/training.controller.dart';
import 'package:get/get.dart';

class TrainingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingController());
    Get.lazyPut(() => TrainingStore(), fenix: true);
  }

}