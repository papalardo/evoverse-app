import 'package:app/core/app.factory.dart';
import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';
import 'package:app/modules/account/infra/models/player-hash-power.model.dart';

import 'base.store.dart';

class UserAccountStore extends BaseStore<UserAccountStore> {
  AccountModel? account;
  PlayerHashPowerModel? playerHashPower;

  @override
  Future<void> fetch() async {
    var walletAddress = await AppFactory.storageClient().get<String>('walletAddress');

    await Future.wait([
      AccountDatasource().fetch(walletAddress!)
          .then((response) => account = response),
      AccountDatasource().getPlayerHashPower()
          .then((response) => playerHashPower = response)
    ]);

  }

}