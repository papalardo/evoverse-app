import "package:app/services/storage/istorage.service.dart";
import "package:get/get.dart";

class AppFactory {
  static StorageServiceContract storageClient() => Get.find<StorageServiceContract>();
}