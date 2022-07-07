import 'package:app/utils/widgets/loader/loader.mixin.dart';
import 'package:get/get.dart';

class StakeController extends GetxController with LoaderMixin {

  @override
  void onReady() {
    // loader.wait(() => Future.delayed(const Duration(seconds: 2)), 'scaffold');

    super.onReady();
  }
}