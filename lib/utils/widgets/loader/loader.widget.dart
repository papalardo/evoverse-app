import 'package:app/utils/theme/app.palette.dart';
import 'package:app/utils/widgets/infinite-rotation.widget.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderWidget extends GetView<LoaderController> {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfiniteRotationWidget(
      child: Image.asset('lib/assets/images/hashpower-fan-center.png',
        height: 80,
        width: 80,
      ),
    );
  }
}
