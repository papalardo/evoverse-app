import 'package:app/modules/player-items/infra/models/player-item-pod.model.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/number.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/loader/shimmer-wrapper.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class PodListTile extends StatelessWidget {
  final PlayerItemPodModel pod;
  final bool selected;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  const PodListTile({
    Key? key,
    required this.pod,
    this.selected = false,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  static const kIconSize = 60.0;

  static const kShapeRadius = 5.0;

  static Widget shimmer() => ShimmerWrapper(
    child: ListTile(
      minVerticalPadding: 20.0,
      tileColor: Colors.white.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kShapeRadius)
      ),
      leading: Container(width: kIconSize, height: kIconSize, color: Colors.white),
      title: Container(width: 70, height: 30, color: Colors.white,)
          .paddingOnly(bottom: 5),
      subtitle: Container(width: 100, height: 20, color: Colors.white,),
    )
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      selected: selected,
      selectedTileColor: AppPalette.byRarity(pod.rarity).withOpacity(0.4),
      selectedColor: Colors.white,
      minVerticalPadding: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kShapeRadius)
      ),
      tileColor: AppPalette.byRarity(pod.rarity),
      leading: Image.asset(asset("images/pod-rarities/${pod.rarity.toLowerCase()}.png"),
        height: kIconSize,
        width: kIconSize,
      ),
      title: Text("POD #${pod.id}")
          .fontSize(12)
          .fontWeight(FontWeight.bold)
          .padding(vertical: 5, horizontal: 15)
          .backgroundColor(AppPalette.gray600)
          .clipRRect(all: 15)
          .paddingOnly(bottom: 5),
      subtitle: Wrap(
        spacing: 15,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          [
            Image.asset(asset("images/fan.png"), width: 15, height: 15), 
            Text(Number.toCurrency(pod.hashPowerTotal))
              .fontSize(10)
              .fontWeight(FontWeight.bold)
          ].toRow(
            separator: const SizedBox(width: 5), 
            mainAxisSize: MainAxisSize.min
          ),
          [
            SvgPicture.asset(asset("svg/star.svg"), width: 15, height: 15),
            Text(pod.stars.toString())
                .fontSize(10)
                .fontWeight(FontWeight.bold)
          ].toRow(
              separator: const SizedBox(width: 5),
              mainAxisSize: MainAxisSize.min
          ),
          if (pod.boosted)
            SvgPicture.asset(asset("svg/boost.svg"), width: 10, height: 10),
          if (pod.mining)
            const Icon(Icons.memory, size: 13),
          if (pod.onSale || pod.onSalePending)
            const Icon(Icons.attach_money, size: 13)
        ],
      )
        .padding(vertical: 5, horizontal: 15)
        .backgroundColor(AppPalette.gray600)
        .clipRRect(all: 15),
    );
  }
}
