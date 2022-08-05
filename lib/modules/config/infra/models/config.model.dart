class ConfigModel {
  int id;
  String field;
  String value;

  ConfigModel({
    required this.id,
    required this.field,
    required this.value,
  });

  factory ConfigModel.fromJson(Map json) => ConfigModel(
    id: json["id"] ?? json['Id'],
    field: json["field"] ?? json['Field'],
    value: json["value"] ?? json['Value'],
  );
}