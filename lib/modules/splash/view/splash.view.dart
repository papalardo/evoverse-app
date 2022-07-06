import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/loader/loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.BROWN,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('lib/assets/logo.svg', width: 300),
            const LoaderWidget(),
          ],
        ),
      ),
    );
  }
}
