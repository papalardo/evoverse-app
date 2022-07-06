import 'package:app/utils/app-platform.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500
              ),
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
                              style: Get.textTheme.headline5!.copyWith(
                                fontWeight: FontWeight.bold
                              ),
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
                                await controller.loader.wait(() => controller.submit())
                                  .catchError((_) => Toast.danger("Invalid access token"));
                                focusNode.requestFocus();
                              },
                            ),
                            // if (! AppPlatform.isDesktop)
                            ElevatedButton(
                              onPressed: () => controller.authFromWallet()
                                .catchError((e) => Toast.danger(e.toString())),
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
      ),
    );
  }

}
