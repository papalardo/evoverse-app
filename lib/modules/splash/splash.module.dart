import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/splash/view/splash.bindings.dart';
import 'package:app/modules/splash/view/splash.view.dart';
import 'package:get/get.dart';

class SplashModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBindings()
    )
  ];
}