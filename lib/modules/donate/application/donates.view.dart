import "package:app/modules/ethereum/infra/models/ethereum-transfer.model.dart";
import "package:app/utils/widgets/loader/loader.widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "package:app/modules/donate/application/store/user-donates.store.dart";

class DonatesPage extends StatelessWidget {
  const DonatesPage({Key? key}) : super(key: key);

  UserDonatesStore get userDonatesStore => Get.find<UserDonatesStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My donates"),
      ),
      body: userDonatesStore.when(
          busy: () => const Center(
            child: LoaderWidget(),
          ),
          done: (List<EthereumTransferModel> donates) => ListView.builder(
            itemCount: donates.length,
            itemBuilder: (BuildContext context, int index) {
              var donate = donates[index];
              return ListTile(
                title: Text("Amount: BUSD ${donate.amount}"),
                subtitle: Text("Date: ${donate.when}"),
              );
            },
          )
      ),
    );
  }
}
