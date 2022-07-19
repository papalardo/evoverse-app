import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

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
      .borderRadius(all: 30)
      .backgroundColor(const Color(0xFF272f3b))
      .card();
  }

  static Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: AppPalette.gray400,
      highlightColor: Colors.white,
      child: [
        [
          SizedBox(height: 10, width: 30,),
          SizedBox(height: 10, width: 30,),
        ].toColumn(
          separator: const SizedBox(height: 5),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        SizedBox(height: 30, width: 30,)
      ].toRow(
        separator: const SizedBox(width: 10),
        mainAxisAlignment: MainAxisAlignment.spaceBetween
      ).card(),
    );
  }

}


