import 'package:app/core/app.module.dart';
import 'package:app/core/app.routes.dart';
import 'package:app/modules/account/application/account.view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AccountModule implements Module {
  @override
  List<GetPage> routes() => [
    GetPage(name: AppRoutes.ACCOUNT, page: () => AccountView()),
  ];

}