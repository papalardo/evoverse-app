import 'package:app/core/app.routes.dart';
import 'package:app/services/http/http.service.dart';
import 'package:app/utils/widgets/errors/maintence.page.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with LoaderMixin {
  @override
  void onReady() {
    onNext();
    super.onReady();
  }

  onNext() async {
    await _checkAvailable();

    await 2.delay();

    Get.offAllNamed(AppRoutes.AUTH);
  }

  Future<void> _checkAvailable() async {
    // Handled on error interceptor
    await Get.find<HttpService>()
        .get('https://farming.evoverse.app');
  }

}