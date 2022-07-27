import "package:app/modules/config/infra/models/config-list.model.dart";
import "package:app/modules/config/utils/config-keys.dart";
import "package:app/modules/raffle/infra/models/raffle-winner.model.dart";

class RaffleDataModel {
  int id;
  int lastId;
  int userTickets;
  num ticketPrice;
  String ticketCurrency;
  DateTime startedAt;
  DateTime endsAt;
  List<RaffleWinnerModel> winners;

  RaffleDataModel({
    required this.id,
    required this.lastId,
    required this.userTickets,
    required this.startedAt,
    required this.ticketPrice,
    required this.ticketCurrency,
    required this.endsAt,
    required this.winners,
  });

  factory RaffleDataModel.fromJson(Map json) {
    var configs = ConfigListModel.fromList(json["raffle_config"]);
    var startsAt = DateTime.parse(json["start_date"]);
    var timeRemaining = configs.value<int>(ConfigKeys.RAFFLE_TIME_REMAINING) ?? 0;
    var endsAt = startsAt.add(Duration(seconds: timeRemaining));
    return RaffleDataModel(
      id: json["open_raffle_id"],
      lastId: json["last_raffle_id"],
      userTickets: json["ticket_count"],
      ticketPrice: configs.value<int>(ConfigKeys.RAFFLE_TICKET_COST, 0)!,
      ticketCurrency: configs.value(ConfigKeys.RAFFLE_TICKET_CURRENCY, "Unknown")!,
      startedAt: startsAt,
      endsAt: endsAt,
      winners: List.from(json["winners"].map((e) => RaffleWinnerModel.fromJson(e))),
    );
  }
}