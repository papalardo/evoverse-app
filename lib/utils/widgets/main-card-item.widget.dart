import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/conditional.widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

class MainCardItemWidget extends StatelessWidget {
  final String? title;
  final String? value;
  final Widget? afterValue;
  final Widget icon;
  final Widget? child;

  const MainCardItemWidget({
    Key? key,
    required this.icon,
    this.title,
    this.value,
    this.child,
    this.afterValue,
  }) : super(key: key);

  static Widget shimmer({
    usingTitle = false
  }) => MainCardItemShimmerWidget(
    usingTitle: usingTitle,
  );

  static const TextStyle valueTextStyle = TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return [
      if (title != null)
        Text(title!)
          .textColor(const Color(0xFF979797)),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: icon,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: [
              if (value != null)
                Text(value!, style: MainCardItemWidget.valueTextStyle),
              if (child != null) child!,
              if (afterValue != null)
                afterValue!,
            ].toRow()
          )
        ],
      )
    ].toColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separator: const SizedBox(height: 5)
    );
  }
}

class MainCardItemShimmerWidget extends StatelessWidget {
  final bool usingTitle;

  const MainCardItemShimmerWidget({
    Key? key,
    this.usingTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Container()
      .backgroundColor(AppPalette.gray400)
      .borderRadius(all: 30)
      .height(30);

    var content = Wrap(
      spacing: 8,
      children: [
        SizedBox(width: 30, child: box),
        SizedBox(width: 150, child: box),
      ],
    );

    return Opacity(
      opacity: 0.2,
      child: Shimmer.fromColors(
        baseColor: AppPalette.gray400,
        highlightColor: Colors.white,
        child: Conditional(usingTitle,
          onFalse: () => content,
          onTrue: () => Wrap(
            direction: Axis.vertical,
            children: [
              SizedBox(width: 130, height: 17, child: box),
              const SizedBox(height: 6),
              content
            ],
          )
        ),
      ),
    );
  }
}