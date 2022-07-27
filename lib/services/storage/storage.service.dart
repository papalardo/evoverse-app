import "package:app/services/storage/istorage.service.dart";
import "package:get_storage/get_storage.dart";

class StorageService implements StorageServiceContract {
  GetStorage box = GetStorage();

  @override
  Future<void> boot() async {
    await GetStorage.init();
  }

  @override
  bool exists(String key) => box.hasData(key);

  @override
  Future<T?> get<T>(String key) async => box.read<T>(key);

  @override
  Future<void> put(String key, dynamic value) => box.write(key, value);

  @override
  Future<void> delete(String key) => box.remove(key);
}