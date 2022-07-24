class AppHttpException implements Exception {
  final String message;
  final int code;

  AppHttpException(this.message, [this.code = 500]);
}