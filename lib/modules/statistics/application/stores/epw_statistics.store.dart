import 'package:app/modules/statistics/infra/datasources/statistics.datasource.dart';
import 'package:app/modules/statistics/infra/models/token.model.dart';
import 'package:app/stores/base.store.dart';
import 'package:get/get.dart';

class EpwStatisticsStore extends BaseStore<EpwStatisticsStore, TokenModel> {
  static EpwStatisticsStore get to => Get.find();

  @override
  Future<TokenModel> fetch() => StatisticsDatasource().epw();
}