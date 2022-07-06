import 'package:app/utils/widgets/errors/maintence.page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Getx;

class ErrorsHandlerInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response == null) {
      return handler.next(err);
    }

    var statusCode = err.response!.statusCode;

    if (statusCode == 503 && await on503()) {
        // return;
    }

    return handler.next(err);
  }

  Future<bool> on503() async {
    Getx.Get.offAll(() => const MaintenancePage());

    return true;
  }
}