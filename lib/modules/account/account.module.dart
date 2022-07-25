import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/account/application/account.bindings.dart';
import 'package:app/modules/account/application/account.view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AccountModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(
      name: AppRoutes.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBindings(),
    ),
  ];

}