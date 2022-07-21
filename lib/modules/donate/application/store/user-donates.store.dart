import 'package:app/modules/ethereum/infra/datasource/ethereum.datasource.dart';
import 'package:app/modules/ethereum/infra/models/ethereum-transfer.model.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/stores/base.store.dart';
import 'package:get/get.dart';

class UserDonatesStore extends BaseStore<UserDonatesStore, List<EthereumTransferModel>> {
  @override
  Future<List<EthereumTransferModel>> fetch() async {
    var _storage = Get.find<StorageServiceContract>();

    var userWallet = await _storage.get('walletAddress');
    return EthereumDatasource().getBusdDonatesFromAddress(userWallet);
  }

}