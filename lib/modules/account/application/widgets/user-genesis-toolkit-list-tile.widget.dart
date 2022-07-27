import "package:app/modules/account/infra/datasources/account.datasource.dart";
import "package:app/modules/account/infra/models/mint-pod.model.dart";
import "package:app/utils/functions.dart";
import "package:flutter/material.dart";

import "package:app/modules/account/application/widgets/mintable-list-tile.widget.dart";

class UserGenesisToolkitListTile extends MintableListTile {
  const UserGenesisToolkitListTile({Key? key}) : super(
      key: key,
      confirmationMessage: "Confirm to open genesis toolkit",
      assetTitle: "Genesis toolkit"
  );

  @override
  int get assetCount => userWorkshopStore.state?.genesisToolkitsTotal ?? 0;

  @override
  Widget get assetImage => Image.asset(asset("images/toolkit-genesis.png"));

  @override
  Future<MintPodModel> mint() => AccountDatasource().openGenesisToolkit();
}
