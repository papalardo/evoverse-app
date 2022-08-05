import 'package:app/modules/player-keys/infra/datasource/player-keys.datasource.dart';
import 'package:app/modules/player-keys/infra/models/player-key.model.dart';
import 'package:get/get.dart';

class PlayerKeysController extends GetxController {
  static PlayerKeysController get to => Get.find();

  Future<List<PlayerKeyModel>> getKeys() => PlayerKeysDatasource().getKeys();
}