import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/donate/application/donates.view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class DonateModule extends Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.DONATE,
      page: () => DonatesPage(),
    )
  ];

}