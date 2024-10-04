abstract class SharedPrefService {
  Future<void> init();

  Future<String?> getString(String key);
  Future<int?> getInt(String key, [int defValue = 0]);
  Future<bool> setString(String key, String value);
  Future<bool> getBool(String key, [bool defValue = false]);
  Future<bool> setBool(String key, bool value);
  Future<bool> containsKey(String key);
  Future<bool> clearData();
  Future<bool> remove(String key);
}
