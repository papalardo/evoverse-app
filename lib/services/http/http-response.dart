import "package:deep_pick/deep_pick.dart";

class HttpResponse {
  final int? statusCode;
  final String body;
  final Map<String, dynamic>? json;

  HttpResponse({
    required this.statusCode,
    required this.body,
    required this.json,
  });

  bool isOk() => isError() == false;

  bool isError() => statusCode == null
    || statusCode! >= 400
    || _errorFromBody();

  bool _errorFromBody() =>
    json == null
    || json!["type"] == "error"
    || json!["type"] == "crash";

  String getMessageError() {
    var message = pick(json, "message").asStringOrNull() ?? "";
    return message.isNotEmpty ? message : "Unknown error";
  }

}