import 'package:app/services/http/http.service.dart';
import 'package:get/get.dart';

class BaseDatasource {
  HttpService httpClient = Get.find<HttpService>();
}