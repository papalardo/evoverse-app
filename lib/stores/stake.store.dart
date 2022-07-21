import 'package:app/modules/stake/infra/datasources/stake.datasource.dart';
import 'package:app/modules/stake/infra/models/stake.model.dart';

import 'base.store.dart';

class StakeStore extends BaseStore<StakeStore, StakeModel> {
  @override
  Future<StakeModel> fetch() => StakeDatasource().fetch();
}