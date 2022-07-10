import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/pod-count.model.dart';

import 'base.store.dart';

class UserPodsStore extends BaseStore<UserPodsStore> {
  List<PodCount> pods = [];

  @override
  Future<void> fetch() async {
    pods = await AccountDatasource().getAccountPods();
  }

}