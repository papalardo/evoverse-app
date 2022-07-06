import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/mining/application/mining.bindings.dart';
import 'package:app/modules/mining/application/mining.view.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MiningModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.MINING,
      page: () => MiningView(),
      binding: MiningBindings(),
      transition: Transition.noTransition
    ),
  ];
  
}