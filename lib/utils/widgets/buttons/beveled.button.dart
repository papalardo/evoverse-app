import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';

class BeveledButton extends ElevatedButton {
  static ButtonStyle baseStyle = ElevatedButton.styleFrom(
      shape: BeveledRectangleBorder(
          side: const BorderSide(color: AppPalette.gray400, width: 1.5),
          borderRadius: BorderRadius.circular(10)
      )
  );

  BeveledButton({
    required VoidCallback? onPressed,
    required Widget? child
  }) : super(
    onPressed: onPressed,
    child: child,
    style: baseStyle
  );

}
