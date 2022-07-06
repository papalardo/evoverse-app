abstract class StorageServiceContract {
  Future boot();

  bool exists(String key);

  Future<T?> get<T>(String key);

  Future<void> put(String key, dynamic value);

  Future<void> delete(String key);
}