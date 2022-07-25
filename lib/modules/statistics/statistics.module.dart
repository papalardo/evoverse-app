import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/statistics/application/statistics.bindings.dart';
import 'package:app/modules/statistics/application/statistics.page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class StatisticsModule extends Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.STATISTICS,
      page: () => const StatisticsPage(),
      binding: StatisticsBindings()
    ),
  ];

}