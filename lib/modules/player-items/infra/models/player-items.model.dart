import "package:app/modules/player-items/infra/models/player-item-pod.model.dart";

class PlayerItemsModel {
  List<PlayerItemPodModel> pods;

  PlayerItemsModel({
    required this.pods,
  });

  factory PlayerItemsModel.fromJson(Map json) => PlayerItemsModel(
    pods: List.from(json["pod_list"].map((e) => PlayerItemPodModel.fromJson(e))),
  );
}