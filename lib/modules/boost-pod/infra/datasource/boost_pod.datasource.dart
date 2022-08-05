import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/boost-pod/infra/models/boost_pod_config.model.dart';

class BoostPodDatasource extends BaseDatasource {
  Future<BoostPodConfigModel> getConfig() async {
    var response = await httpClient.post("GetBoostPodConfig");

    return BoostPodConfigModel.fromList(response.json!['data']);
  }
}