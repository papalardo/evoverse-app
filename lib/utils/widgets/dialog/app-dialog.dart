import 'dart:math';
import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class AppDialog extends StatelessWidget {
  final Widget child;
  final Widget? icon;
  final bool disableCloseButton;

  const AppDialog({
    Key? key,
    required this.child,
    this.icon,
    this.disableCloseButton = false,
  }) : super(key: key);

  double get avatarRadius => icon != null ? 50.0 : 0;

  static const kBorderWidth = 5.0;

  factory AppDialog.confirm({
    required String title,
    required BuildContext context,
    required void Function() onConfirm,
    String? message,
  }) => AppDialog(
    disableCloseButton: true,
    child: [
      Text(title, style: Get.textTheme.headline6),
      if (message != null)
        Text(message, style: Get.textTheme.bodyMedium, textAlign: TextAlign.center,),
      Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 15,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
            style: ElevatedButton.styleFrom(
              primary: AppPalette.gray400,
              shape: StadiumBorder()
            ),
          ),
          ElevatedButton(
            onPressed: onConfirm,
            child: Text("Confirm"),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder()
            ),
          ),
        ],)
    ].toColumn(
      mainAxisSize: MainAxisSize.min,
      separator: const SizedBox(height: 10)
    ),
);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: avatarRadius + 20
              ),
              margin: EdgeInsets.only(top: max(0, avatarRadius - kBorderWidth/2)),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppPalette.gray400,
                  width: kBorderWidth
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppPalette.primary600
              ),
              child: child,
            ),
            closeButton(context: context),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                child: icon,
                radius: avatarRadius,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget closeButton({
    required BuildContext context,
  }) {
    if (disableCloseButton) {
      return const SizedBox();
    }
    return Positioned(
        top: avatarRadius + 15,
        right: 15,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: AppPalette.gray400,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            padding: EdgeInsets.all(3),
            color: Colors.white,
            icon: Icon(Icons.close, size: 15,),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
    );
  }
}
