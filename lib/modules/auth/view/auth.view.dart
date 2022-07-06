import 'package:app/core/app.routes.dart';
import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/services/http/http.service.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth.controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.BACKGROUND,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 75),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 15,
                        top: 75
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.gray600,
                        border: const Border.fromBorderSide(
                          BorderSide(width: 3, color: AppPalette.GRAY)
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Connect your account",
                            style: Get.textTheme.headline5,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            focusNode: focusNode,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (v) => controller.token = v,
                            decoration: const InputDecoration(
                              hintText: 'Access Token',
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            child: Text("Connect".toUpperCase()),
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              await controller.submit();
                              focusNode.requestFocus();
                            },
                          ),
                          ElevatedButton(
                            onPressed: () => openWallet(),
                            child: Text("Connect with wallet")
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset('lib/assets/images/evo_head.png',
                    width: 150,
                    height: 150,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  connect(WalletConnect connector, int chainId, String walletAddress) async {
    if (chainId != 56) {
      Toast.danger("Invalid chain");
    }

    var responseNonce = await AccountDatasource().fetch(walletAddress);

    launchUrl(Uri.parse(connector.session.toUri()));

    var messageToSign = "evoverse.app signing: ${responseNonce.nonce}";

    try {

      var responseWallet = await connector.sendCustomRequest(
          method: 'personal_sign',
          params: [walletAddress, messageToSign]
      );

      var response = await Get.find<HttpService>()
          .post('JWTVerifySignature', {
            'signature': responseWallet,
            'wallet_address': walletAddress
          });

      await Get.find<StorageServiceContract>()
        .put('accessToken', response.body!['token']);

      Get.offAllNamed(AppRoutes.MINING);

    } catch (e) {
      print("e ==> $e");
    }
  }

  openWallet() async {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'EvoVerse',
        // description: 'WalletConnect Developer App',
        url: 'https://farming.evoverse.app',
        icons: [
          'https://farming.evoverse.app/assets/img/Gameart-Animus_rbx_32px.png'
        ],
      ),
    );

    // Subscribe to events
    connector.on('connect', (session) => print("session ==> $session"));
    connector.on('session_update', (WCSessionUpdateResponse payload) {
      connect(connector, payload.chainId, payload.accounts[0]);
    });
    connector.on('disconnect', (session) => print("session ==> $session"));

    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 56,
        onDisplayUri: (uri) => launchUrl(Uri.parse(uri)),
      );

      connect(connector, session.chainId, session.accounts[0]);
    }

  }
}
