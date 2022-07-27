import "package:app/utils/theme/app.palette.dart";
import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class ShimmerWrapper extends StatelessWidget {
  final Widget child;

  const ShimmerWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Shimmer.fromColors(
        baseColor: AppPalette.gray400,
        highlightColor: Colors.white,
        child: child,
      ),
    );
  }
}
