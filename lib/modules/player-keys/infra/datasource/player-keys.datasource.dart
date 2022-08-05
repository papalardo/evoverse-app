import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/player-keys/infra/models/player-key.model.dart';

class PlayerKeysDatasource extends BaseDatasource {
  putToSale(int keyId, int amount) async {
    await httpClient.post("AddItemToSale", {
      "nft_id": keyId,
      "nft_type": "EKEY",
      "selling_price": amount.toDouble(),
    });
  }

  Future<List<PlayerKeyModel>> getKeys() async {
    var response = await httpClient.post("GetPlayerItems", {
      "page_number": 0,
      "nft_type": "Pod"
    });

    return List.from(response.json!['data']['PlayerInfo']['key_list']
        .map((e) => PlayerKeyModel.fromJson(e)));
  }

}