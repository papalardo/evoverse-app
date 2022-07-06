import 'package:app/services/storage/istorage.service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Getx;

class AuthorizationInterceptor extends Interceptor {
  var storage = Getx.Get.find<StorageServiceContract>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await storage.get('accessToken');

    if (token != null) {
      options.headers.addAll({
        'Authorization': token,
      });
    }

    return handler.next(options);
  }

}