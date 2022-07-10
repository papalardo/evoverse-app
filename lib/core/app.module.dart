import 'package:app/modules/account/account.module.dart';
import 'package:app/modules/auth/auth.module.dart';
import 'package:app/modules/mining/mining.module.dart';
import 'package:app/modules/splash/splash.module.dart';
import 'package:app/modules/stake/application/modules/stake-epw/stake-epw.module.dart';
import 'package:app/modules/stake/stake.module.dart';
import 'package:get/get.dart';

abstract class Module {
  List<GetPage> routes();
}

class AppModule implements Module {
  @override
  List<GetPage> routes() => [
    ...SplashModule().routes(),
    ...AuthModule().routes(),
    ...AccountModule().routes(),
    ...MiningModule().routes(),
    ...StakeModule().routes(),
    ...StakeEpwModule().routes(),
  ];


}
