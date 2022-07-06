import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/stake/application/stake.bindings.dart';
import 'package:app/modules/stake/application/stake.view.dart';
import 'package:get/get.dart';

class StakeModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.STAKE,
      page: () => StakeView(),
      binding: StakeBindings(),
      transition: Transition.noTransition
    )
  ];

}