import 'package:app/exceptions/http-exception.dart';
import 'package:app/modules/training/infra/datasources/training.datasource.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:get/get.dart';

import 'package:app/modules/training/application/stores/training.store.dart';

class TrainingController extends GetxController {
  static TrainingController get to => Get.find();

  var trainingSelected = 0.obs;
  var buyAmount = 1.obs;

  bidTraining(String selectedEvo) async {
    var store = Get.find<TrainingStore>();

    try {
      await TrainingDatasource().bigTraining(
        trainingId: store.state!.trainings[trainingSelected()].id,
        evo: selectedEvo,
        amount: buyAmount()
      );
    } on AppHttpException catch (err) {
      Toast.danger(err.message);
      rethrow;
    }
  }

}