class HttpResponse {
  int? statusCode;

  Map<String, dynamic>? body;

  HttpResponse({
    this.statusCode,
    this.body,
  });

  bool isOk() => isError() == false;

  bool isError() => statusCode == null
    || statusCode! >= 400
    || body!['type'] == 'error'
    || body!['type'] == 'crash';
}