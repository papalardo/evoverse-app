import "package:app/core/base/base.datasource.dart";
import "package:app/modules/mining/infra/models/mining.model.dart";

class MiningDatasource extends BaseDatasource {
  Future<MiningModel> fetch() async {
    var response = await httpClient.post("GetPreFarmingLabData");

    return MiningModel.fromJson(response.json!["data"]);
  }

  Future<void> energize() async {
    var response = await httpClient.post("EnergizeAllPods", {
      "is_epw_to_claim": false
    });

    if (response.isError()) {
      throw response.getMessageError();
    }

  }

}