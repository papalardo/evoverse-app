import 'package:app/modules/boost-pod/infra/datasource/boost_pod.datasource.dart';
import 'package:app/modules/boost-pod/infra/models/boost_pod_config.model.dart';
import 'package:app/stores/base.store.dart';
import 'package:get/get.dart';

class BoostPodStore extends BaseStore<BoostPodStore, BoostPodConfigModel> {
  static BoostPodStore get to => Get.find();

  @override
  Future<BoostPodConfigModel> fetch() => BoostPodDatasource().getConfig();
}