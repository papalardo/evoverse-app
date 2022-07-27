import "package:app/core/base/base.datasource.dart";
import "package:app/modules/stake/infra/models/stake-preview.model.dart";
import "package:app/modules/stake/infra/models/stake.model.dart";

class StakeDatasource extends BaseDatasource {
  Future<StakeModel> fetch() async {
    var response = await httpClient.post("GetStakingInfo");

    return StakeModel.fromJson(response.json!["data"]);
  }

  Future<StakePreviewModel> preview(int amount) async {
    var response = await httpClient.post("PreviewStakeEPW", {
      "amount": amount,
    });

    return StakePreviewModel.fromJson(response.json!["data"]["preview"]);
  }

  Future<bool> stake(int amount) async {
    await httpClient.post("StakeEPW", {
      "amount": amount,
    });

    return true;
  }

  Future<bool> unstake(int amount) async {
    await httpClient.post("UnstakeEPW", {
      "amount": amount,
    });

    return true;
  }

  Future<bool> claimEkey() async {
    await httpClient.post("ClaimEKEY");
    return true;
  }

}