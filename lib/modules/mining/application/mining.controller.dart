import 'package:app/modules/mining/infra/datasources/mining.datasource.dart';
import 'package:app/modules/mining/infra/models/claim-cost.model.dart';
import 'package:app/modules/mining/infra/models/mining.model.dart';
import 'package:app/stores/mining.store.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:get/get.dart';

class MiningController extends GetxController with LoaderMixin {
  Future<void> energize() async {
    await MiningDatasource().energize();
  }

  Future<void> claim() async {
    await Future.delayed(Duration(seconds: 2));
  }

}