import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/stake/application/modules/stake-epw/application/stake-epw.view.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import 'application/stake-epw.bindings.dart';

class StakeEpwModule extends Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.STAKE_EPW,
      page: () => const StakeEpwView(),
      binding: StakeEpwBindings(),
      transition: Transition.downToUp,
      curve: Curves.easeInOut
    )
  ];

}