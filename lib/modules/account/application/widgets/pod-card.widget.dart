import "package:app/utils/widgets/main-card-item.widget.dart";
import "package:flutter/material.dart";

class PodCardWidget extends StatelessWidget {
  final String rarity;
  final int qty;
  
  const PodCardWidget({
    required this.rarity,
    required this.qty,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String assetPath = "lib/assets/images/pod-rarities/${rarity.toLowerCase()}.png";

    return MainCardItemWidget(
      icon: Image.asset(assetPath),
      value: "$qty #$rarity",
    );
  }
}

