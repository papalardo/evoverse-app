import 'dart:convert';

import 'package:app/services/http/interceptors/authorization.interceptor.dart';
import 'package:app/services/http/interceptors/errors-handler.interceptor.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/utils/widgets/errors/maintence.page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Getx;

import 'http-response.dart';

class HttpService {
  // GetConnect client = GetConnect();
  var client = Dio();

  var storage = Getx.Get.find<StorageServiceContract>();

  boot() async {
    client.options.baseUrl = 'https://api.evoverse.app/';

    client.interceptors.addAll([
      AuthorizationInterceptor(),
      ErrorsHandlerInterceptor(),
    ]);

  }

  Future<HttpResponse> get(String url) => client.get(url)
      .then((r) => _handleResponse(r));

  Future<HttpResponse> post(String url, [dynamic body]) => client.post(url, data: body)
      .then((r) => _handleResponse(r));

  _handleResponse(Response<dynamic> response) => HttpResponse(
    statusCode: response.statusCode,
    body: _handleBody(response.data)
  );

  Map<String, dynamic>? _handleBody(String? body) {
    print("body ==> ${body}");

    if (body == null) {
      return null;
    }

    var rootBody = jsonDecode(body);
    return jsonDecode(rootBody['body']);
  }

}