import 'package:app/core/base/base.datasource.dart';
import 'package:app/modules/statistics/infra/models/token.model.dart';
import 'package:app/utils/logger.dart';

class StatisticsDatasource extends BaseDatasource {

  Future<TokenModel> epw() async {
    var response = await httpClient.get('https://api.pancakeswap.info/api/v2/tokens/0xf0e5096edf070dc9b1bc8911d63c4e448a3e14c6');

    var data = response.json!['data'];
    data['image'] = "images/rpw_verde.png";

    return TokenModel.fromJson(data);
  }

  Future<TokenModel> evs() async {
    var response = await httpClient.get('https://api.pancakeswap.info/api/v2/tokens/0x576ac55622333c7193447d20b985ed8ed096065b');

    var data = response.json!['data'];
    data['image'] = "images/evo_head.png";

    return TokenModel.fromJson(data);
  }

}