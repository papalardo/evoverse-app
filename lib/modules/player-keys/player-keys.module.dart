import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/player-keys/application/player-keys.bindings.dart';
import 'package:app/modules/player-keys/application/player-keys.page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class PlayerKeysModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.playerKeys,
      page: () => const PlayerKeysPage(),
      binding: PlayerKeysBindings()
    ),
  ];

}