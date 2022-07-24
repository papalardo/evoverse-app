import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/mint-pod.model.dart';
import 'package:app/utils/functions.dart';
import 'package:flutter/material.dart';

import 'mintable-list-tile.widget.dart';

class UserHexToolkitListTile extends MintableListTile {
  const UserHexToolkitListTile({Key? key}) : super(
      key: key,
      confirmationMessage: "Confirm to open hex toolkit",
      assetTitle: "Hex toolkit"
  );

  @override
  int get assetCount => userWorkshopStore.state?.hexToolkitsTotal ?? 0;

  @override
  Widget get assetImage => Image.asset(asset("images/toolkit-hex.png"));

  @override
  Future<MintPodModel> mint() => AccountDatasource().openHexToolkit();
}