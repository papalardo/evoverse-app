import 'package:app/modules/player-keys/infra/datasource/player-keys.datasource.dart';
import 'package:app/modules/player-keys/infra/models/player-key.model.dart';
import 'package:get/get.dart';

class PlayerKeysController extends GetxController {
  static PlayerKeysController get to => Get.find();

  final buttonAvailableIndex = 0;
  final buttonForSaleIndex = 1;

  var selectedIndex = 0.obs;

  List<PlayerKeyModel> filterKeys(List<PlayerKeyModel> keys) {
    if (selectedIndex() == buttonAvailableIndex) {
      return keys.where((key) => key.onSale() == false).toList();
    }

    if (selectedIndex() == buttonForSaleIndex) {
      return keys.where((key) => key.onSale() == true).toList();
    }

    return keys;
  }

  Future<void> removeFromSale(int keyId) => PlayerKeysDatasource()
      .removeFromSale(keyId);

  Future<void> openKey() => PlayerKeysDatasource().openKey();

}