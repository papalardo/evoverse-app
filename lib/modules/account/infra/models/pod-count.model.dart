class PodCount {
  String rarity;
  int qty;

  PodCount({
    required this.rarity,
    required this.qty,
  });

  factory PodCount.fromJson(Map json) => PodCount(
    rarity: json['rarity'],
    qty: json['count'],
  );

}