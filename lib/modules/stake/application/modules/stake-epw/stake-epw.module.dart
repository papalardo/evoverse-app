import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/stake/application/modules/stake-epw/application/stake-epw.view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'application/stake-epw.bindings.dart';

class StakeEpwModule extends Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.STAKE_EPW,
      page: () => StakeEpwView(),
      binding: StakeEpwBindings()
    )
  ];

}