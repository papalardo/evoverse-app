import "package:app/modules/account/infra/datasources/account.datasource.dart";
import "package:app/modules/account/infra/models/player-hash-power.model.dart";
import "package:app/stores/base.store.dart";

class UserHashPowerStore extends BaseStore<UserHashPowerStore, PlayerHashPowerModel> {
  @override
  Future<PlayerHashPowerModel> fetch() => AccountDatasource().getPlayerHashPower();
}