import "package:app/exceptions/http-exception.dart";
import "package:app/modules/raffle/infra/datasources/raffle.datasource.dart";
import "package:app/utils/toast/toast.dart";
import "package:app/utils/widgets/loader/loader-state.mixin.dart";
import "package:get/get.dart";

class RaffleController extends GetxController with LoaderStateMixin {
  var buyAmount = 1.obs;

  Future<void> buyTicket() async {
    try {
      await RaffleDatasource().buyTickets(buyAmount());
    } on AppHttpException catch (err) {
      Toast.danger(err.message);
      rethrow;
    }
  }
}