import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

class Conditional extends StatelessWidget {
  final bool condition;
  final Widget Function()? onTrue;
  final Widget Function()? onFalse;

  const Conditional(this.condition, {
    this.onFalse,
    this.onTrue,
    Key? key,
  }) : super(key: key);

  static dynamic fn(bool condition, {
    dynamic Function()? onTrue,
    dynamic Function()? onFalse,
  }) {
    if (condition) {
      return onTrue == null ? null : onTrue();
    }
    return onFalse == null ? null : onFalse();
  }

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return onTrue != null ? onTrue!() : nil;
    }
    return onFalse != null ? onFalse!() : nil;
  }

}
