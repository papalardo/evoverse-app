import "dart:async";
import 'dart:io';

import "package:app/modules/account/infra/datasources/account.datasource.dart";
import "package:app/modules/wallet/infra/datasources/wallet.datasource.dart";
import "package:app/services/http/http.service.dart";
import "package:app/services/storage/istorage.service.dart";
import 'package:app/utils/logger.dart';
import "package:app/utils/toast/toast.dart";
import 'package:flutter/services.dart';
import "package:get/get.dart";
import "package:url_launcher/url_launcher.dart";
import "package:walletconnect_dart/walletconnect_dart.dart";

class WalletController extends SuperController<WalletController> {
  final httpClient = Get.find<HttpService>();
  final storageClient = Get.find<StorageServiceContract>();

  static WalletController get to => Get.find();

  final connector = WalletConnect(
    bridge: "https://bridge.walletconnect.org",
    clientMeta: const PeerMeta(
      name: "EvoVerse",
      // description: 'WalletConnect Developer App',
      url: "https://farming.evoverse.app",
      icons: [
        "https://farming.evoverse.app/assets/img/Gameart-Animus_rbx_32px.png"
      ],
    ),
  );

  String? get walletAddress => connector.session.accounts.isEmpty
      ? null
      : connector.session.accounts[0];

  @override
  onInit() {
    // connector.on("connect", (session) => print("session ==> $session"));
    // connector.on("session_update", (WCSessionUpdateResponse payload) {
    //   logger.i('payload =+> ${payload}');
    //   signMessage(payload.chainId, payload.accounts[0]);
    // });
    // connector.on("disconnect", (session) => print("session ==> $session"));

    super.onInit();
  }

  @override
  onResumed() => reconnectNeeding();

  reconnectNeeding() {
    if (connector.bridgeConnected == false) {
      logger.w('Wallet connected, but transport is down.  Attempt to recover.');
      connector.reconnect();
    }
  }

  Future<WalletConnectSession?> connect() async {
    reconnectNeeding();

    if (connector.connected) {
      logger.d(
          'createWalletConnectSession - WalletConnect Already connected to ${connector.session.peerMeta?.name}. Ignored.');


      return connector.session;
    }

    SessionStatus session;
    try {

      session = await connector.createSession(
        chainId: 56,
        onDisplayUri: (uri) async {
          bool? result;

          try {
            result = await launchUrl(Uri.parse(uri), mode: LaunchMode.externalApplication);
            if (result == false) {
              // launch alternative method
              logger.e('Initial launchuri failed. Fallback launch with forceSafariVC true');
              result = await launchUrl(Uri.parse(uri));
              if (result == false) {
                logger.e('Could not launch $uri');
              }
            }
            if (result) {
              logger.i('Launched wallet app, requesting session.');
            }

          } on PlatformException catch (e) {
            if (e.code == 'ACTIVITY_NOT_FOUND') {
              logger.w('No wallets available - do nothing!');
              return;
            }
            logger.e('launch returned $result');
            logger.e('Unexpected PlatformException error: ${e.message}, code: ${e.code}, details: ${e.details}');
          } on Exception catch (e) {
            logger.e('launch returned $result');
            logger.e('url launcher other error e: $e');
          }

        },
      );
     } catch (e) {
      logger.e('Unable to connect - killing the session on our side. $e');
      connector.killSession();
      return null;
    }

    if (session.accounts.isEmpty) {
      logger.e('Failed to connect to wallet.  Bridge Overloaded? Could not Connect?');
      return null;
    }

    print("connector ==> ${connector.session.toUri()}");

    return connector.session;
  }

  signMessage(int chainId, String walletAddress) async {
    if (chainId != 56) {
      Toast.danger("Invalid chain");
    }

    var nonce = await getNonce(walletAddress);

    String walletConnectTopicVersion = 'wc:${connector.session.handshakeTopic}@${connector.session.version}';

    logger.i("walletConnectTopicVersion => $walletConnectTopicVersion");

    await launchUrl(Uri.parse(walletConnectTopicVersion), mode: LaunchMode.externalApplication);

    // If the wallet isn't already opened, give it a change to startup
    sleep(const Duration(milliseconds: 1000));

    var messageToSign = createSignMessage(nonce.toString());

    logger.i("messageToSign => ${messageToSign}");

    dynamic requestResult = await connector.sendCustomRequest(
        method: "personal_sign",
        params: [messageToSign, walletAddress]
    );

    logger.i("requestResult ==> $requestResult");

    return requestResult;
    // var completer = Completer<String>();
    //
    // signingRequest.then((signature) async {
    //   completer.complete(signature);
    // });
    //
    // return completer.future;
  }

  String asciiToHex(String asciiStr) {
    List<int> chars = asciiStr.codeUnits;
    StringBuffer hex = StringBuffer();
    for (int ch in chars) {
      hex.write(ch.toRadixString(16).padLeft(2, '0'));
    }
    return hex.toString();
  }

  String createSignMessage(String nonce) => '0x' + asciiToHex("evoverse.app signing: $nonce");

  Future<num> getNonce(String walletAddress) {
    return AccountDatasource().fetch(walletAddress)
        .then((response) => response.nonce);
  }

  Future<void> authenticate(String signature, [String? walletAddress]) async {
    var accessToken = await WalletDatasource().getAccessToken(
        signature,
        walletAddress ?? connector.session.accounts[0],
    );

    await storageClient.put("accessToken", accessToken.token);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

}