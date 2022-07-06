import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';

class AccountDatasource extends BaseDatasource {
  Future<AccountModel> fetch() async {
    var response = await httpClient.post('GetPlayerWallet', {
      'wallet_address': '0x522be008db71bac39a54df3dae5de419daae62f6'
    });

    return AccountModel.fromJson(response.body!['data']['wallet']['wallet_data']);
  }

}