import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/raffle/infra/models/raffle-data.model.dart';

class RaffleDatasource extends BaseDatasource {
  Future<RaffleDataModel> fetchData() async {
    var response = await httpClient.post('GetRaffleData');

    return RaffleDataModel.fromJson(response.json!['data']);
  }
}