import "package:app/utils/functions.dart";
import "package:app/utils/theme/app.palette.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:shimmer/shimmer.dart";
import "package:styled_widget/styled_widget.dart";

class StatisticCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? text1;
  final String? text2;
  final String image;

  const StatisticCard({
    Key? key,
    this.title,
    this.description,
    this.text1,
    this.text2,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      [
        if (title != null)
          Text(title!, style: Get.textTheme.headline6),
        if (description != null)
          Text(description!, style: Get.textTheme.bodySmall),
        if (text1 != null)
          Text(text1!),
        if (text2 != null)
          Text(text2!),
      ]
        .toColumn(
          separator: const SizedBox(height: 5),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      Image.asset(asset(image), width: 30, height: 30),
    ]
      .toRow(
        separator: const SizedBox(width: 10),
        mainAxisAlignment: MainAxisAlignment.spaceBetween
      )
      .padding(vertical: 10, horizontal: 15)
      .card(color: const Color(0xFF272f3b));
  }

  static Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: AppPalette.gray400,
      highlightColor: Colors.white,
      child: [
        [
          Container(height: 25, width: 50, color: Colors.white),
          Container(height: 20, width: 70, color: Colors.white),
        ].toColumn(
          separator: const SizedBox(height: 5),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        const CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
        ),
      ].toRow(
          separator: const SizedBox(width: 10),
          mainAxisAlignment: MainAxisAlignment.spaceBetween
      ),
    )
    .padding(vertical: 10, horizontal: 15)
    .card(color: const Color(0xFF272f3b));
  }

}


