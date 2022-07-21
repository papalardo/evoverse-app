import 'package:app/utils/string.utils.dart';

class EthereumTransferModel {
  DateTime when;
  num amount;

  EthereumTransferModel({
    required this.when,
    required this.amount
  });

  factory EthereumTransferModel.fromJson(Map json) => EthereumTransferModel(
    when: DateTime.fromMillisecondsSinceEpoch(int.parse(json['timeStamp']) * 1000),
    amount: StringUtils.hexToAmount(json['data'])
  );
}