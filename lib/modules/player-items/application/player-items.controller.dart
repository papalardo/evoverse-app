import "package:app/exceptions/http-exception.dart";
import "package:app/modules/player-items/infra/datasource/player-items.datasource.dart";
import "package:app/modules/player-items/infra/models/player-items.model.dart";
import "package:app/utils/toast/toast.dart";
import "package:app/utils/widgets/loader/loader-state.mixin.dart";
import "package:app/utils/widgets/loader/loader.controller.dart";
import "package:get/get.dart";

class PlayerItemsController extends GetxController with LoaderStateMixin {
  final _datasource = PlayerItemsDatasource();
  final globalLoader = Get.find<LoaderController>();

  bool selecting = false;
  List<int> selected = [];

  double priceToSale = 0;

  Future<PlayerItemsModel> getItems() {
    return _datasource.getItems(PlayerItemsNftType.pod);
  }

  void toggleSelecting() {
    selecting = !selecting;
    if (selecting == false) {
      selected = [];
    }
    update();
  }

  void toggleSelected(int podInt) {
    selected.contains(podInt) ? selected.remove(podInt) : selected.add(podInt);

    update();
  }

  Future<void> boostPod(int podId) async {
    try {
      await _datasource.boostPod(podId);
    } on AppHttpException catch (err) {
      Toast.danger(err.message);
    }
  }

  putSale(int podId, num price) async {
    try {
      await _datasource.salePod(podId, price);
    } on AppHttpException catch (err) {
      Toast.danger(err.message);
    } finally {
      update();
    }
  }
}
