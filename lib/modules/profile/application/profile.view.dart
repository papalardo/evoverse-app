import "package:app/core/app.routes.dart";
import "package:app/services/storage/istorage.service.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/theme/app.palette.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import "package:styled_widget/styled_widget.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const double kIconSize = 25;
  static const double kImageSize = 30;
  
  Widget listTile({
    required String label,
    required Widget icon,
    required Function() onTap,
  }) => ListTile(
    shape: BeveledRectangleBorder(
      side: const BorderSide(color: AppPalette.gray400, width: 1.5),
      borderRadius: BorderRadius.circular(10)
    ),
    trailing: icon,
    title: Text(label.toUpperCase())
      .fontWeight(FontWeight.bold)
      .fontSize(14)
      .letterSpacing(3),
    onTap: onTap,
  );
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: [
          // ListTile(
          //   title: Text("My Donates"),
          //   onTap: () => Get.toNamed(AppRoutes.DONATE),
          // ),
          listTile(
            icon: SvgPicture.asset(asset("svg/raffle.svg"),
              width: kImageSize,
              height: kImageSize,
            ),
            label: "Raffle",
            onTap: () => Get.toNamed(AppRoutes.raffles),
          ),
          listTile(
            icon: Image.asset(asset("images/training.png"),
              width: kImageSize,
              height: kImageSize,
            ),
            label: "Training",
            onTap: () => Get.toNamed(AppRoutes.training),
          ),
          listTile(
            icon: const Icon(Icons.logout, size: kIconSize),
            label: "Logout",
            onTap: () async {
              await Get.find<StorageServiceContract>().delete("accessToken");
              Get.offAllNamed(AppRoutes.AUTH);
            },
          ),
        ].toColumn(
          separator: const SizedBox(height: 10)
        ),
      ),
    );
  }
}
