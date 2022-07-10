import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/workshop-info.model.dart';

import 'base.store.dart';

class UserWorkshopStore extends BaseStore<UserWorkshopStore> {
  WorkshopInfoModel? workshop;

  @override
  Future<void> fetch() async {
    workshop = await AccountDatasource().workshopInfo();
  }

}