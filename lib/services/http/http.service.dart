import 'dart:convert';

import 'package:app/services/http/interceptors/authorization.interceptor.dart';
import 'package:app/services/http/interceptors/errors-handler.interceptor.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:app/utils/widgets/errors/maintence.page.dart';
import 'package:deep_pick/deep_pick.dart';
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
    statusCode: _handleStatusCode(response),
    body: response.data.toString(),
    json: _handleBody(response.data)
  );

  int? _handleStatusCode(Response<dynamic> response) {
    var json = _handleBody(response.data);

    var responseType = pick(response.data, 'type').asStringOrNull() ?? 'success';

    if (responseType == 'error' || responseType == 'crash') {
      return pick(response.data, 'statusCode').asIntOrNull() ?? 400;
    }

    return json?['statusCode']
        ?? response.statusCode
        ?? 200;
  }

  Map<String, dynamic>? _handleBody(dynamic body) {
    if (body is String) {
      return null;
    }

    if (body is Map && body.containsKey('body')) {
      if (body['body'] is Map) {
        return body['body'];
      }

      return jsonDecode(body['body']);
    }

    return body;
  }

}