import "package:app/modules/account/infra/datasources/account.datasource.dart";
import "package:app/modules/account/infra/models/mint-pod.model.dart";
import "package:app/utils/functions.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "package:app/modules/account/application/widgets/mintable-list-tile.widget.dart";

class UserEkeyListTile extends MintableListTile {
  const UserEkeyListTile({Key? key}) : super(
      key: key,
      confirmationMessage: "Confirm to open ekey",
      assetTitle: "Keys"
  );

  @override
  int get assetCount => userWorkshopStore.state?.eKeys.toInt() ?? 0;

  @override
  Widget get assetImage => SvgPicture.asset(asset("svg/ekey.svg"));

  @override
  Future<MintPodModel> mint() => AccountDatasource().mintByEkey();
}