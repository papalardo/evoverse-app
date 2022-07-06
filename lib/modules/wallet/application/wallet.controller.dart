import 'dart:async';

import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/wallet/infra/datasources/wallet.datasource.dart';
import 'package:app/services/http/http.service.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/utils/life-cycle-event-handler.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletController extends GetxController {
  final httpClient = Get.find<HttpService>();
  final storageClient = Get.find<StorageServiceContract>();

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

  String? get walletAddress => connector.session.accounts.isEmpty
      ? null
      : connector.session.accounts[0];

  @override
  onInit() {
    connector.on('connect', (session) => print("session ==> $session"));
    connector.on('session_update', (WCSessionUpdateResponse payload) {
      signMessage(payload.chainId, payload.accounts[0]);
    });
    connector.on('disconnect', (session) => print("session ==> $session"));

    super.onInit();
  }

  Future<WalletConnectSession> connect() async {
    if (connector.connected) {
      return connector.session;
    }

    await connector.createSession(
      chainId: 56,
      onDisplayUri: (uri) => launchUrl(Uri.parse(uri)),
    );

    print("connector ==> ${connector.session.toUri()}");

    return connector.session;
  }

  signMessage(int chainId, String walletAddress) async {
    if (chainId != 56) {
      Toast.danger("Invalid chain");
    }

    var nonce = await getNonce(walletAddress);

    var messageToSign = createSignMessage(nonce.toString());

    var signingRequest = connector.sendCustomRequest(
        method: 'personal_sign',
        params: [walletAddress, messageToSign]
    );

    launchUrl(Uri.parse(connector.session.toUri()));

    var completer = Completer<String>();

    signingRequest.then((signature) async {
      completer.complete(signature);
    });

    return completer.future;
  }

  String createSignMessage(String nonce) => "evoverse.app signing: $nonce";

  Future<num> getNonce(String walletAddress) {
    return AccountDatasource().fetch(walletAddress)
        .then((response) => response.nonce);
  }

  Future<void> authenticate(String signature, [String? walletAddress]) async {
    var accessToken = await WalletDatasource().getAccessToken(
        signature,
        walletAddress ?? connector.session.accounts[0],
    );

    await storageClient.put('accessToken', accessToken.token);
  }

}