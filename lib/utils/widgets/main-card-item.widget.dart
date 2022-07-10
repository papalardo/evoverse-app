import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/conditional.widget.dart';
import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;
import 'package:shimmer/shimmer.dart';

class MainCardItemWidget extends StatelessWidget {
  final String? title;
  final String? value;
  final Widget icon;
  final Widget? child;

  const MainCardItemWidget({
    Key? key,
    required this.icon,
    this.title,
    this.value,
    this.child
  }) : super(key: key);

  static Widget shimmer({
    usingTitle = false
  }) => MainCardItemShimmerWidget(
    usingTitle: usingTitle,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 5,
      children: [
        if (title != null)
        Text(title!, style: const TextStyle(
            color: Color(0xFF979797)
        )),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: icon,
            ),
            if (child != null) child!,
            if (value != null)
              Text(value!, style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold
              )),
          ],
        )
      ],
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
    var box = n.Box()
      ..height = 30
      ..rounded
      ..backgroundColor = AppPalette.gray400;

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