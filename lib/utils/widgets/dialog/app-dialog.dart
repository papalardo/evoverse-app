import 'package:app/utils/functions.dart';
import 'package:app/utils/theme/app.palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class AppDialog extends StatelessWidget {
  final Widget child;

  const AppDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  static const kAvatarRadius = 50.0;
  static const kBorderWidth = 5.0;

  factory AppDialog.confirm({
    required String title,
    String? message,
    required BuildContext context,
    required void Function() onConfirm,
  }) => AppDialog(
    child: [
      Text(title, style: Get.textTheme.headline6),
      if (message != null)
        Text(message, style: Get.textTheme.bodyMedium),
      Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 15,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
            style: ElevatedButton.styleFrom(
                primary: AppPalette.gray400
            ),
          ),
          ElevatedButton(onPressed: onConfirm, child: Text("Confirm")),
        ],)
    ].toColumn(
      mainAxisSize: MainAxisSize.min,
      separator: const SizedBox(height: 5)
    ),
);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(bottom: kAvatarRadius, left: 24, right: 24),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: kAvatarRadius + 10
            ),
            margin: EdgeInsets.only(top: kAvatarRadius),
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              child: Image.asset(asset('images/evo_head.png')),
              radius: kAvatarRadius,
            ),
          )
        ],
      ),
    );
  }
}
