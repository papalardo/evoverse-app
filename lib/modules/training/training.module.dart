import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/training/application/training.bindings.dart';
import 'package:app/modules/training/application/training.page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class TrainingModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.training,
      page: () => const TrainingPage(),
      binding: TrainingBindings(),
    )
  ];

}