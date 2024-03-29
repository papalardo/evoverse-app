
import "package:app/core/app.routes.dart";
import "package:app/utils/widgets/errors/maintence.page.dart";
import "package:dio/dio.dart";
import "package:get/get.dart" as Getx;

class ErrorsHandlerInterceptor extends Interceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    verifyIfErrorOnRequest(response);

    return super.onResponse(response, handler);
  }

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

  verifyIfErrorOnRequest(Response response) {
    var message = "";
    var type = "success";
    var statusCode = response.statusCode ?? 200;

    try {
      statusCode = response.data["statusCode"];
      message = response.data['body']['message'];
    } catch (e) {
      //
    }

    try {
      message = response.data["message"];
    } catch (e) {
      //
    }

    try {
      type = response.data["type"];
    } catch (e) {
      //
    }

    if (message.contains("Session is invalid")) {
      if (Getx.Get.currentRoute != AppRoutes.AUTH) {
        Getx.Get.offAllNamed(AppRoutes.AUTH);
      }

      throw message;
    }

    if (type == "error" || statusCode >= 400) {
      throw message;
    }
  }

}