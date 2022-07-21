class ConfigModel {
  String field;
  String value;

  ConfigModel({
    required this.field,
    required this.value,
  });

  factory ConfigModel.fromJson(Map json) => ConfigModel(
    field: json['field'],
    value: json['value'],
  );
}