import "package:app/utils/theme/app.palette.dart";
import "package:flutter/material.dart";

class TinyButton extends ElevatedButton {
  TinyButton({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child
  }) : super(key: key,
    onPressed: onPressed,
    child: child,
    style: ElevatedButton.styleFrom(
        primary: AppPalette.PRIMARY,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
    )
  );
}