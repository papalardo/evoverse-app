import "package:app/modules/raffle/infra/datasources/raffle.datasource.dart";
import "package:app/modules/raffle/infra/models/raffle-data.model.dart";
import "package:app/stores/base.store.dart";

class RaffleDataStore extends BaseStore<RaffleDataStore, RaffleDataModel> {
  @override
  Future<RaffleDataModel> fetch() => RaffleDatasource().fetchData();
}