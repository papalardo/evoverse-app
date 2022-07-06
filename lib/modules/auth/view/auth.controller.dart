import 'package:app/core/app.routes.dart';
import 'package:app/modules/wallet/application/wallet.controller.dart';
import 'package:app/modules/wallet/infra/datasources/wallet.datasource.dart';
import 'package:app/services/http/http.service.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController with LoaderMixin {
  final _storageClient = Get.find<StorageServiceContract>();
  var _httpClient = Get.find<HttpService>();

  String token = '';

  @override
  void onReady() {
    loader.wait(() => submit());

    super.onReady();
  }

  submit() async {
    if (token.isNotEmpty) {
      await _storageClient.put('accessToken', token);
    }

    if (token.isEmpty) {
      var storageToken = await _storageClient.get<String>('accessToken');
      if (storageToken != null) {
        token = storageToken;
      }
    }

    var response = await _httpClient.post('GetPreFarmingLabData');

    if (response.isError()) {
      await _storageClient.delete('accessToken');
      return;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    await _storageClient.put('walletAddress', decodedToken['wallet_address']);

    Get.offAllNamed(AppRoutes.INITIAL);
  }

  authFromWallet() async {
    var walletController = Get.find<WalletController>();

    var session = await walletController.connect();

    var walletAddress = session.accounts[0];

    var signature = await walletController.signMessage(
      session.chainId,
      session.accounts[0],
    );

    await walletController.authenticate(signature, walletAddress);

    await _storageClient.put('walletAddress', walletAddress);

    Get.offAllNamed(AppRoutes.INITIAL);
  }

}