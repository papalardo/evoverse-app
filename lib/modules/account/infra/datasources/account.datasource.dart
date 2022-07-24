import 'package:app/core/base/base.datasource.dart';
import 'package:app/exceptions/http-exception.dart';
import 'package:app/modules/account/infra/models/account.model.dart';
import 'package:app/modules/account/infra/models/mint-pod.model.dart';
import 'package:app/modules/account/infra/models/player-hash-power.model.dart';
import 'package:app/modules/account/infra/models/pod-count.model.dart';
import 'package:app/modules/account/infra/models/workshop-info.model.dart';

class AccountDatasource extends BaseDatasource {
  Future<AccountModel> fetch(String walletAddress) async {
    var response = await httpClient.post('GetPlayerWallet', {
      'wallet_address': walletAddress
    });

    var walletData = response.json?['data']?['wallet']?['wallet_data'];

    return AccountModel.fromJson(walletData);
  }

  Future<WorkshopInfoModel> workshopInfo() async {
    var response = await httpClient.post('GetWorkshopInfo', {
      // 'wallet_address': walletAddress
    });

    return WorkshopInfoModel.fromJson(response.json!['data']);
  }

  Future<List<PodCount>> getAccountPods() async {
    var response = await httpClient.post('GetPlayerPodCount', {
      // 'wallet_address': walletAddress
    });

    var pods = response.json!['data']['pod_count'];

    return List<PodCount>.from(pods.map((item) => PodCount.fromJson(item)));
  }

  Future<PlayerHashPowerModel> getPlayerHashPower() async {
      var response = await httpClient.post('GetPlayerHashPower');

      return PlayerHashPowerModel.fromJson(response.json!['data']);
  }

  Future<MintPodModel> mintByEkey() async {
    var response = await httpClient.post('UseKey');

    return MintPodModel.fromJson(response.json!['data']['pod']);
  }

  Future<MintPodModel> openCommonToolkit() async {
    throw AppHttpException("Not implemented yet");

    // TODO:: Endpoint common toolkit
    var response = await httpClient.post('');

    return MintPodModel.fromJson(response.json!['data']['pod']);
  }

  Future<MintPodModel> openHexToolkit() async {
    throw AppHttpException("Not implemented yet");

    // TODO:: Endpoint hex toolkit
    var response = await httpClient.post('');

    return MintPodModel.fromJson(response.json!['data']['pod']);
  }

  Future<MintPodModel> openGenesisToolkit() async {
    throw AppHttpException("Not implemented yet");

    // TODO:: Endpoint genesis toolkit
    var response = await httpClient.post('');

    return MintPodModel.fromJson(response.json!['data']['pod']);
  }

  Future<MintPodModel> fakeMint() async {
    await Future.delayed(const Duration(seconds: 1));

    return MintPodModel(
      podId: 9999,
      rarity: 'Legendary',
      hashPower: 15.0,
      isGenesis: false,
    );
  }

}