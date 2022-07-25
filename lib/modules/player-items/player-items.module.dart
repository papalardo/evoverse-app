import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:get/get.dart';

import 'application/player-items.bindings.dart';
import 'application/player-items.page.dart';

class PlayerItemsModule extends Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.PLAYER_ITEMS,
      page: () => const PlayerItemsPage(),
      binding: PlayerItemsBindings(),
    )
  ];

}