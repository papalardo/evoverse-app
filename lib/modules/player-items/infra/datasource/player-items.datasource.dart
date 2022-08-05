import "package:app/core/base/base.datasource.dart";
import "package:app/modules/player-items/infra/models/player-items.model.dart";

class PlayerItemsNftType {
    static const pod = "Pod";
    static const key = "EKEY";
}

class PlayerItemsDatasource extends BaseDatasource {
  Future<PlayerItemsModel> getItems(String assetType) async {
    var response = await httpClient.post("GetPlayerItems", {
      "page_number": 0,
      "nft_type": "Pod"
    });

    return PlayerItemsModel.fromJson(response.json!["data"]["PlayerInfo"]);
  }

  Future boostPod(int podId) async {
    await httpClient.post("BoostPod", {
      "nft_id": podId,
    });
  }

  Future salePod(int podId, num price) async {
    await httpClient.post("AddItemToSale", {
      "nft_id": podId,
      "nft_type": "Pod",
      "selling_price": price.toDouble(),
    });
  }

}