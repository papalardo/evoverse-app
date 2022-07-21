import 'package:app/core/app.factory.dart';
import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';
import 'package:app/modules/account/infra/models/player-hash-power.model.dart';
import 'package:app/modules/mining/infra/datasources/mining.datasource.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';

import 'base.store.dart';

class MiningStore extends BaseStore<MiningStore, MiningModel> {
  @override
  Future<MiningModel> fetch() => MiningDatasource().fetch();
}