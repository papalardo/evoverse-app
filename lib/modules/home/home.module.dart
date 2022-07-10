import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/home/application/home.bindings.dart';
import 'package:app/modules/home/application/home.page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const HomePage(),
      binding: HomeBindings()
    )
  ];
  
}