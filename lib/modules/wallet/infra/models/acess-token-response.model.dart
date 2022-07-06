class AccessTokenResponse {
  String token;

  AccessTokenResponse({
    required this.token
  });

  factory AccessTokenResponse.fromJson(Map json) => AccessTokenResponse(
      token: json['token']
  );
}