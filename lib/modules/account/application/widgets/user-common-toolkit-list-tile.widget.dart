import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/mint-pod.model.dart';
import 'package:app/utils/functions.dart';
import 'package:flutter/material.dart';

import 'mintable-list-tile.widget.dart';

class UserCommonToolkitListTile extends MintableListTile {
  const UserCommonToolkitListTile({Key? key}) : super(
    key: key,
    confirmationMessage: "Confirm to open common toolkit",
    assetTitle: "Common toolkit"
  );

  @override
  int get assetCount => userWorkshopStore.state?.commonToolkitsTotal ?? 0;

  @override
  Widget get assetImage => Image.asset(asset("images/toolkit-common.png"));

  @override
  Future<MintPodModel> mint() => AccountDatasource().openCommonToolkit();
}
