import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';

class AccountDatasource extends BaseDatasource {
  Future<AccountModel> fetch(String walletAddress) async {
    var response = await httpClient.post('GetPlayerWallet', {
      'wallet_address': walletAddress
    });

    return AccountModel.fromJson(response.body!['data']['wallet']['wallet_data']);
  }

}