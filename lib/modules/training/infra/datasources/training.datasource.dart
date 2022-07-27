import "package:app/core/base/base.datasource.dart";
import "package:app/modules/training/infra/models/training-data.model.dart";

class TrainingDatasource extends BaseDatasource {
  Future<TrainingDataModel> fetchData() async {
    var response = await httpClient.post("GetEvoTrainingData");

    return TrainingDataModel.fromJson(response.json!["data"]);
  }

  Future<void> bigTraining({
    required int trainingId,
    required String evo,
    required int amount,
  }) async {
    await httpClient.post('BuyEvoTrainingRechargeTicket', {
      "training_id": trainingId,
      "selected_evo": evo,
      "amount": amount
    });
  }

}