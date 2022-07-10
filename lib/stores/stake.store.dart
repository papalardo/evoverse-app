import 'package:app/core/app.factory.dart';
import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';
import 'package:app/modules/account/infra/models/player-hash-power.model.dart';
import 'package:app/modules/mining/infra/datasources/mining.datasource.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/modules/stake/infra/datasources/stake.datasource.dart';
import 'package:app/modules/stake/infra/models/stake.model.dart';

import 'base.store.dart';

class StakeStore extends BaseStore<StakeStore> {
  StakeModel? stake;

  @override
  void onInit() {
    reload();
    super.onInit();
  }

  @override
  Future<void> fetch() async {
    stake = await StakeDatasource().fetch();
  }

}