import 'dart:math';

import 'package:flutter/material.dart';

class InfiniteRotationWidget extends StatefulWidget {
  final Widget child;
  final bool enable;

  const InfiniteRotationWidget({
    required this.child,
    this.enable = true,
    Key? key
  }) : super(key: key);

  @override
  State<InfiniteRotationWidget> createState() => _InfiniteRotationWidgetState();
}

class _InfiniteRotationWidgetState extends State<InfiniteRotationWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
  )..repeat();

  @override
  dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (! widget.enable) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
