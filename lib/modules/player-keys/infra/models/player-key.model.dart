class PlayerKeyModel {
  int id;
  double? sellingPrice;

  PlayerKeyModel({
    required this.id,
    this.sellingPrice,
  });

  factory PlayerKeyModel.fromJson(Map json) {
    return PlayerKeyModel(
      id: json['id'],
      sellingPrice: json['selling_price'],
    );
  }

  bool onSale() => sellingPrice != null;
}