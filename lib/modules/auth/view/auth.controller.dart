import "package:app/core/app.routes.dart";
import "package:app/modules/wallet/application/wallet.controller.dart";
import 'package:app/modules/wallet/infra/datasources/wallet.datasource.dart';
import "package:app/services/http/http.service.dart";
import "package:app/services/storage/istorage.service.dart";
import 'package:app/utils/logger.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/theme/app.theme-data.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/buttons/beveled.button.dart';
import "package:app/utils/widgets/loader/loader.mixin.dart";
import 'package:flutter/material.dart';
import "package:get/get.dart";
import "package:jwt_decoder/jwt_decoder.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';

class AuthController extends GetxController with LoaderMixin {
  final _storageClient = Get.find<StorageServiceContract>();
  final _httpClient = Get.find<HttpService>();

  String token = "";

  @override
  void onReady() {
    loader.wait(() => submit());

    super.onReady();
  }

  submit() async {
    var token = await _storageClient.get<String>("accessToken");

    if (token == null) {
      return;
    }

    try {
      await _httpClient.post("GetPreFarmingLabData");
    } catch (e) {
      await _storageClient.delete("accessToken");
      return;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    await _storageClient.put("walletAddress", decodedToken["wallet_address"]);

    Get.offAllNamed(AppRoutes.INITIAL);
  }

  authFromWallet({required BuildContext context}) async {
    // Create a connector
    final qrCodeModal = WalletConnectQrCodeModal(
      connector: WalletConnect(
        bridge: "https://bridge.walletconnect.org",
        clientMeta: const PeerMeta(
          name: "EvoVerse",
          // description: 'WalletConnect Developer App',
          url: "https://farming.evoverse.app",
          icons: [
            "https://farming.evoverse.app/assets/img/Gameart-Animus_rbx_32px.png"
          ],
        ),
      ),
    );

    qrCodeModal.registerListeners(onConnect: (session) {
      print("onConnect session ==> ${session}");
    }, onSessionUpdate: (session) {
      print("onSessionUpdate session ==> ${session}");
    }, onDisconnect: () {
      print("onDisconnect");
    });

    var walletAddress = "";
    var result = await qrCodeModal.connect(
      context,
      chainId: 56,
      builder: (context, widget) {
        return Theme(
          data: ThemeData(),
          child: widget,
        );
      }
    );

    if (result == null) {
      return;
    }

    if (result.accounts.isNotEmpty) {
      walletAddress = result.accounts[0];
    }

    var nonce = await WalletController().getNonce(walletAddress);

    await launchUrl(
      Uri.parse(qrCodeModal.connector.session.toUri()),
      mode: LaunchMode.externalApplication,
    );

    var messageToSign = WalletController().createSignMessage(nonce.toString());
    var signature = await qrCodeModal.connector.sendCustomRequest(
        method: "personal_sign", params: [messageToSign, walletAddress]);

    logger.i("requestResult ==> ${signature}");

    await loader
        .wait(() => WalletController().authenticate(signature, walletAddress));

    await _storageClient.put("walletAddress", walletAddress);

    Get.offAllNamed(AppRoutes.INITIAL);
  }

  _authFromWallet() async {
    var walletController = Get.find<WalletController>();

    var session = await walletController.connect();
    if (session == null) {
      Toast.danger("Error");
      return;
    }
    var walletAddress = session.accounts[0];

    logger.i("walletAddress ==> $walletAddress");

    String signature = "";
    try {
      signature = await walletController.signMessage(
        session.chainId,
        session.accounts[0],
      );
    } catch (e) {
      Toast.danger(e.toString());
      walletController.connector.killSession();
      return;
    }

    await loader
        .wait(() => walletController.authenticate(signature, walletAddress));

    await _storageClient.put("walletAddress", walletAddress);

    Get.offAllNamed(AppRoutes.INITIAL);
  }
}
