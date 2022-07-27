import "package:app/core/app.module.dart";
import "package:app/core/app.routes.dart";
import "package:app/modules/raffle/application/raffle.page.dart";
import "package:get/get_navigation/src/routes/get_route.dart";

import "package:app/modules/raffle/application/raffle.bindings.dart";

class RaffleModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.RAFFLE,
      page: () => const RafflePage(),
      binding: RaffleBindings(),
    )
  ];
}