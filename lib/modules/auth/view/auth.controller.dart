import 'package:app/core/app.routes.dart';
import 'package:app/services/http/http.service.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with LoaderMixin {
  String token = '';

  @override
  void onReady() {
    submit();
    super.onReady();
  }

  submit() async {
    loader.show();

    var storage = Get.find<StorageServiceContract>();
    var http = Get.find<HttpService>();

    if (token.isNotEmpty) {
      await storage.put('accessToken', token);
    }

    var response = await http.post('GetPreFarmingLabData');

    loader.hide();

    if (response.isError()) {
      Toast.danger("Invalid access token");

      await storage.delete('accessToken');
      return;
    }

    Get.offAllNamed(AppRoutes.MINING);
  }
}