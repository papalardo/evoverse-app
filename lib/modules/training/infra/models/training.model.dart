import 'dart:convert';

class TrainingModel {
  int id;
  DateTime startsAt;
  String type;
  List<String> evos;

  TrainingModel({
    required this.id,
    required this.startsAt,
    required this.type,
    required this.evos,
  });
  
  factory TrainingModel.fromJson(Map json) {
    return TrainingModel(
      id: json['id'],
      startsAt: DateTime.parse(json["start_date"]),
      type: json['training_type'],
      evos: List.from(jsonDecode(json['evos'])),
    );
  }

}