import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/player-keys/infra/models/player-key.model.dart';

class PlayerKeysDatasource extends BaseDatasource {
  Future<void> putToSale(int keyId, int amount) async {
    await httpClient.post("AddItemToSale", {
      "nft_id": keyId,
      "nft_type": "EKEY",
      "selling_price": amount.toDouble(),
    });
  }

  Future<void> openKey() async {
    await httpClient.post("UseKey");
  }

  Future<void> removeFromSale(int keyId) async {
    await httpClient.post("RemoveItemFromSale", {
      "sale_id": keyId,
    });
  }

  Future<List<PlayerKeyModel>> getAll() async {
    return Future.wait([
      getFromMarketplace(),
      getFromWallet(),
    ])
    .then((responses) {
      return [
        ...responses[0],
        ...responses[1]
      ];
    });
  }
  
  Future<List<PlayerKeyModel>> getFromWallet() async {
    var response = await httpClient.post("GetPlayerItems", {
      "page_number": 0,
      "nft_type": "EKEY"
    });

    var result = response.json!['data']['PlayerInfo']['key_list']
        .map((e) => {
          'id': e['NFTId']
        })
        .map((e) => PlayerKeyModel.fromJson(e));

    return List.from(result);
  }

  Future<List<PlayerKeyModel>> getFromMarketplace() async {
    var response = await httpClient.post('GetMarketplaceItems', {
      "nft_type": ["EKEY"],
      "page_number": 1,
      "self_only": "selling",
      "stars_min": 1,
      "stars_max": 6
    });
    
    return List.from(response.json!['data']['items']['sale_items']
        .map((e) => PlayerKeyModel.fromJson(e)));
  }



}