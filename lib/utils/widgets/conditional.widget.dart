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

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return onTrue != null ? onTrue!() : nil;
    }
    return onFalse != null ? onFalse!() : nil;
  }

}
