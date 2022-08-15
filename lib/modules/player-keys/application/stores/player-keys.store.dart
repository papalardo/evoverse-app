import 'package:app/modules/player-keys/infra/datasource/player-keys.datasource.dart';
import 'package:app/modules/player-keys/infra/models/player-key.model.dart';
import 'package:app/stores/base.store.dart';
import 'package:get/get.dart';

class PlayerKeysStore extends BaseStore<PlayerKeysStore, List<PlayerKeyModel>> {
  static PlayerKeysStore get to => Get.find();

  @override
  Future<List<PlayerKeyModel>> fetch() => PlayerKeysDatasource().getAll();
}
