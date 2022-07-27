import "package:app/core/app.routes.dart";
import "package:app/modules/auth/view/auth.bindings.dart";
import "package:app/modules/auth/view/auth.view.dart";
import "package:app/core/app.module.dart";
import "package:get/get_navigation/src/routes/get_route.dart";

class AuthModule extends Module {

  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.AUTH,
      page: () => AuthView(),
      binding: AuthBindings()
    )
  ];

}