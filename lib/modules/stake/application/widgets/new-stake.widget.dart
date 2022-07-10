import 'package:app/core/app.routes.dart';
import 'package:app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewStakeWidget extends StatelessWidget {
  const NewStakeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          spacing: 5,
          children: [
            Column(
              children: [
                const Text("Stake"),
                const SizedBox(height: 5),
                Image.asset(asset("images/rpw_verde.png"),
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Icon(Icons.arrow_right_alt, size: 60),
            Column(
              children: [
                const Text("Reward"),
                const SizedBox(height: 5),
                SvgPicture.asset(asset("svg/ekey.svg"),
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          child: Text("Stake EPW"),
          onPressed: () => Get.toNamed(AppRoutes.STAKE_EPW),
        ),
        const SizedBox(height: 10),
        const Text("Stake EPW to receive EKEY fragments as reward.")
      ],
    );
  }
}
