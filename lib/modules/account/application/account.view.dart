import 'package:app/modules/account/infra/datasources/account.datasource.dart';
import 'package:app/modules/account/infra/models/account.model.dart';
import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AccountDatasource().fetch(),
        builder: (context, AsyncSnapshot<AccountModel> snapshot) {
          if (snapshot.hasData) {
            var account = snapshot.data!;
            return Column(
              children: [
                Text("EPW: ${account.epw}"),
                Text("EVS: ${account.evs}"),
              ],
            );
          }

          return CircularProgressIndicator();
        }
      ),
    );
  }
}
