import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/workshop-info.model.dart';

import 'base.store.dart';

class UserWorkshopStore extends BaseStore<UserWorkshopStore, WorkshopInfoModel> {
  @override
  Future<WorkshopInfoModel> fetch() => AccountDatasource().workshopInfo();
}