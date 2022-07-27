import "package:app/core/base/base.datasource.dart";
import "package:app/modules/ethereum/constants.dart";
import "package:app/modules/ethereum/infra/models/ethereum-transfer.model.dart";
import "package:app/modules/ethereum/utils/ethereum.utils.dart";
import "package:app/services/http/http-response.dart";

String _transferTopic = "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef";
String _apiKey = "7MX2PDJPST38T8R7F536R484YIVZGWKWFG";
String _busdAddress = "0xe9e7cea3dedca5984780bafc599bd69add087d56";

class EthereumDatasource extends BaseDatasource {
  EthereumDatasource() {
    // TODO:: Está setando pra toda a aplicação
    // httpClient.client.options.baseUrl = 'https://api.bscscan.com/api';
  }

  Future<HttpResponse> getTokenTransfers(
    String tokenAddress, 
    String senderAddress, 
    String recipientAddress
  ) async {
    return httpClient.get("https://api.bscscan.com/api", {
      "module": "logs",
      "action": "getLogs",
      "fromBlock": 0,
      "toBlock": "latest",
      "address": tokenAddress,
      "topic0": EthereumConstants.topicTransfer,
      "topic1": EthereumUtils.addressToTopic(senderAddress),
      "topic2": EthereumUtils.addressToTopic(recipientAddress),
      "apikey": EthereumConstants.bscApiKey
    });
  }

  Future<List<EthereumTransferModel>> getBusdDonatesFromAddress(String senderAddress) async {
    var response = await getTokenTransfers(
      EthereumConstants.bUsdAddress,
      senderAddress,
      EthereumConstants.donateWalletAddress
    );

    return List.from(response.json!["result"].map((transfer) {
      return EthereumTransferModel.fromJson(transfer);
    }));
  }

}