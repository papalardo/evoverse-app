import 'dart:convert';

import 'package:dio/dio.dart';

class AppFormatterInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var body = response.data;

    try {
      response.data = jsonDecode(body['body']);
    } catch(e) {
      //
    }

    handler.next(response);
  }

}