import 'package:app/exceptions/http-exception.dart';
import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/mint-pod.model.dart';
import 'package:app/stores/user-workshop.store.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/logger.dart';
import 'package:app/utils/toast/toast.dart';
import 'package:app/utils/widgets/buttons/tiny.button.dart';
import 'package:app/utils/widgets/dialog/app-dialog.dart';
import 'package:app/utils/widgets/dialog/mint-pod-result.dialog.dart';
import 'package:app/utils/widgets/loader/loader.controller.dart';
import 'package:app/utils/widgets/main-card-item.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'mintable-list-tile.widget.dart';

class UserEkeyListTile extends MintableListTile {
  const UserEkeyListTile({Key? key}) : super(
      key: key,
      confirmationMessage: "Confirm to open ekey",
      assetTitle: "Keys"
  );

  @override
  int get assetCount => userWorkshopStore.state?.eKeys.toInt() ?? 0;

  @override
  Widget get assetImage => SvgPicture.asset(asset('svg/ekey.svg'));

  @override
  Future<MintPodModel> mint() => AccountDatasource().mintByEkey();
}