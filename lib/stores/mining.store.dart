import "package:app/modules/mining/infra/datasources/mining.datasource.dart";
import "package:app/modules/mining/infra/models/mining.model.dart";

import "package:app/stores/base.store.dart";

class MiningStore extends BaseStore<MiningStore, MiningModel> {
  @override
  Future<MiningModel> fetch() => MiningDatasource().fetch();
}