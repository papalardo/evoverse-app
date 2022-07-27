import "package:app/modules/account/infra/datasources/account.datasource.dart";
import "package:app/modules/account/infra/models/pod-count.model.dart";

import "package:app/stores/base.store.dart";

class UserPodsStore extends BaseStore<UserPodsStore, List<PodCount>> {
  @override
  Future<List<PodCount>> fetch() => AccountDatasource().getAccountPods();
}