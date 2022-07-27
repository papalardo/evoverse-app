import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';

class BeveledButton extends ElevatedButton {
  BeveledButton({
    required VoidCallback? onPressed,
    required Widget? child
  }) : super(
    onPressed: onPressed,
    child: child,
    style: ElevatedButton.styleFrom(
      shape: BeveledRectangleBorder(
        side: const BorderSide(color: AppPalette.gray400, width: 1.5),
        borderRadius: BorderRadius.circular(10)
      )
    )
  );

}
