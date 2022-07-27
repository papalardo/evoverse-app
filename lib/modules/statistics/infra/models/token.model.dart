class TokenModel {
  String name;
  String symbol;
  String price;
  String priceBNB;
  String image;

  TokenModel({
    required this.name,
    required this.symbol,
    required this.price,
    required this.priceBNB,
    required this.image,
  });

  factory TokenModel.fromJson(Map json) => TokenModel(
    name: json["name"],
    symbol: json["symbol"],
    price: json["price"].toString().substring(0, 6),
    priceBNB: json["price_BNB"].toString().substring(0, 6),
    image: json["image"],
  );

}