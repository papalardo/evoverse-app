import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/wallet/infra/models/acess-token-response.model.dart';

class WalletDatasource extends BaseDatasource {
  Future<AccessTokenResponse> getAccessToken(String signature, String walletAddress) async {
    var response = await httpClient
      .post('JWTVerifySignature', {
        'signature': signature,
        'wallet_address': walletAddress
      });

    return AccessTokenResponse.fromJson(response.json!);
  }

}