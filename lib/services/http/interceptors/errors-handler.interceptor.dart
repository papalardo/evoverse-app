import 'dart:convert';

import 'package:app/core/app.routes.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/errors/maintence.page.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Getx;

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
    var message = '';

    try {
      var body = jsonDecode(response.data['body']);
      message = body['message'];
    } catch (e) {
      return;
    }

    if (message.contains('Session is invalid')) {
      if (Getx.Get.currentRoute != AppRoutes.AUTH) {
        Getx.Get.offAllNamed(AppRoutes.AUTH);
      }

      throw message;
    }
  }

}