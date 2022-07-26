import 'package:app/core/app.routes.dart';
import 'package:app/services/storage/istorage.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ListTile(
        //   title: Text("My Donates"),
        //   onTap: () => Get.toNamed(AppRoutes.DONATE),
        // ),
        ListTile(
          title: const Text("Raffle"),
          onTap: () => Get.toNamed(AppRoutes.RAFFLE),
        ),
        ListTile(
          title: const Text("Logout"),
          onTap: () async {
            await Get.find<StorageServiceContract>()
                .delete('accessToken');

            Get.offAllNamed(AppRoutes.AUTH);
          },
        )
      ],
    );
  }
}
