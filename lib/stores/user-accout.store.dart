import "package:app/core/app.factory.dart";
import "package:app/modules/account/infra/datasources/account.datasource.dart";
import "package:app/modules/account/infra/models/account.model.dart";

import "package:app/stores/base.store.dart";

class UserAccountStore extends BaseStore<UserAccountStore, AccountModel> {
  @override
  Future<AccountModel> fetch() async {
    var walletAddress = await AppFactory.storageClient().get<String>("walletAddress");
    return AccountDatasource().fetch(walletAddress!);
  }
}